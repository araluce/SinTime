module Runtastic
  class UserHelper

    def self.build_or_retrieve(loginInformation)
      begin
        @user = UserRuntastic.find_by(email: loginInformation[:email])
        @user[:password] = loginInformation[:password]
        @user[:runtastic_id] = loginInformation[:user]['id']
      rescue ActiveRecord::RecordNotFound
        user_name = loginInformation[:user]['first_name'] + ' ' + loginInformation[:user]['last_name']
        @user = UserRuntastic.new(
            {
                name: user_name,
                age: loginInformation[:user]['age'],
                email: loginInformation[:user]['email'],
                password: loginInformation[:password]
            }
        )
      end
      @user

    end

  end
end
