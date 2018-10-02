class UserRuntastic < ApplicationRecord
  before_save :encrypted_consumer_key

  belongs_to :user, inverse_of: :user_runtastic
  has_many :activity_logs, inverse_of: :user_runtastic

  def perform
    code = 1 # Logged and updated
    begin
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.salt)
      loginInformation = Runtastic::LoginService.login(email, crypt.decrypt_and_verify(self.password))
      code = 2 if process_activities(loginInformation).empty? # code = 2 Already up to date
    rescue RestClient::Unauthorized
      code = 0 # Unauthorized
    end

    code
  end

  private

  def process_activities(loginInformation)
    activities = Runtastic::RuntasticActivitiesService.new().get_activities(loginInformation[:user]['slug'],  loginInformation[:user]['id'], self.id, loginInformation[:authenticationToken], loginInformation[:cookies]);

    activities.each do |activity|
      attributes = activity[:data]['data']['attributes']
      activity_type = activity[:data]['included'].select { |object| object['type'] == 'sport_type' }.first

      self.activity_logs.create(
          activity_id: activity[:activity_id],
          date: activity[:date],
          activity_type: activity_type['attributes']['name'],
          duration: attributes['duration'],
          distance: attributes['distance'],
          average_speed: attributes['average_speed'],
          start_time: attributes['start_time'].to_datetime,
          end_time: attributes['end_time'].to_datetime,
          activity_created_at: attributes['created_at'].to_datetime,
          activity_updated_at: attributes['updated_at'].to_datetime,
          completed: attributes['completed'],
          data: activity[:data]
      ) rescue nil
    end
  end

  def encrypted_consumer_key
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.salt)
    encrypted_password = crypt.encrypt_and_sign(self.password)
    self.password = encrypted_password
  end
end
