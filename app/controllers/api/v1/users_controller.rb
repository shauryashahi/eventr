module Api::V1
  class UsersController < ApiController

    def user_profile
      render json: {:data => build_user_info(@current_user), :message => "Success"}, status: 200
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
