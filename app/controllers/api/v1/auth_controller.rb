module Api::V1
  class AuthController < ApiController

    def login_with_fb
      flag, user, auth_token = User.login_with_facebook(params[:fb_access_token])
      if flag
        user.add_user_to_sendbird
        render json: {:data=>build_user_info(user),:access_token=>auth_token,:message=>"Logged In"}, status: 200
      else
        render json: {:data=>{}, :access_token=>nil, :message => "Cannot Login right now. Try again after a while."}, status: 422
      end
    end

    def logout
      authenticate_with_http_token do |token, options|
        if @current_user.logout(token)
          render json: {:message => "Succesfully Logged Out"}, status: 200
        else
          render json: {:message => "Cannot Log Out right now. Try again after a while."}, status: 400
        end
      end
    end

    private

      def build_user_info user
        data = Hash.new
        data["id"] = user.id
        data["uuid"] = user.uuid
        data["fb_id"] = user.fb_id
        data["name"] = user.name
        data["email"] = user.email
        data["pic_url"] = user.pic_url
        data["eventr_credits"] = user.credits.sum(:eventr_credits)
        data["total_events_attended"] = user.user_groups.where(:event_attended=>true).count
        data
      end
  end
end