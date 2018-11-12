module Runtastic
  class RuntasticActivitiesService
    include ServiceModule

    def get_activities(slug, runtastic_user_id, user_id, authenticationToken, cookies)
      response = RestClient.get('https://www.runtastic.com/en/users/token/sport-sessions'.gsub('token', slug),
                                headers = create_request(authenticationToken, cookies))

      data = Nokogiri::HTML(response.body).search("script[contains('index_data')]").inner_html
      first_index = data.index('index_data') + 'index_data ='.length
      last_index = data.index(';') - 1;
      data_final = data[first_index..last_index]
      activities = Array.new
      data_final = JSON.parse data_final
      data_final.each do |activity_record|
        unless Runtastic::ActivityHelper.existActivity(user_id,activity_record[0]) #avoid doing another request
          detail = self.get_activity_details(runtastic_user_id, authenticationToken, cookies,{:activity_id => activity_record[0], :date => activity_record[1]})
          activities.push(detail) unless !detail
        end
      end
      activities
    end

    def get_activity_details(id, authenticationToken,cookies, activity)
      url = 'https://hubs.runtastic.com/samples/v2/users/token/samples/activityId?include=trace_collection%2Cneighbourhood%2Ccity%2Ccountry%2Csport_type%2Ccreation_application%2Czones'.gsub('token', id.to_s).gsub('activityId',activity[:activity_id].to_s)
      response = RestClient.get(url, headers = create_request(authenticationToken, cookies))

      activity_detail = JSON.parse response.body

      activity[:data] = activity_detail
      activity[:date] = activity[:date].to_date
      activity
    end

  end
end