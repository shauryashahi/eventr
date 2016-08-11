module Api::V1
  class AuthController < ApiController

    def login_with_fb
      flag, user, auth_token = User.login_with_facebook(params[:fb_access_token])
      if flag
        render json: {:data=>user.reload.attributes,:access_token=>auth_token,:message=>"Logged In"}, status: 200
      else
        render json: {:data=>{}, :access_token=>nil, :message => "Cannot Login right now. Try again after a while."}, status: 422
      end
    end

    def logout
      authenticate_with_http_token do |token, options|
        @current_user.logout(token)
        render json: {:message => "Succesfully Logged Out"}, status: 200
      end
    end
  end
end