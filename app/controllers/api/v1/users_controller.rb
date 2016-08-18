module Api::V1
  class UsersController < ApiController

    def user_profile
      render json: {:data => @current_user.attributes.except("fb_token"), :message => "Success"}, status: 200
    end

  end
end
