module Api::V1
  class GroupsController < ApiController
    # before_action :set_group, only: [:group_members, :destroy, :confirm_member, :join_group, :invite_members]

    def event_groups
      if params[:fb_event_id].present?
        # groups = Group.where(:fb_event_id=>params[:fb_event_id])
        # render json: {:data=>groups.as_json,:message => "Success"}, status: 200
        render json: {:data=>Constants::DUMMY_EVENT_GROUPS, :message=>"Success"}, status: 200
      else
        render json: {:message => "Cannot find FB Event ID. Check Input Parameters."}, status: 400
      end
    end

    def user_groups
      # render json: {:data=>@current_user.groups.as_json,:message=>"Success"}, status: 200
      render json: {:data=>Constants::DUMMY_EVENT_GROUPS, :message=>"Success"}, status: 200
    end

    def group_members
      # render json: {:data=>@group.users.except(:fb_token).as_json,:message=>"Success"}, status: 200
      render json: {:data=>Constants::DUMMY_GROUP_MEMBERS, :message=>"Success"}, status: 200
    end

    # def create
    # end

    # def invite_members
    # end

    # def join_group
    # end

    # def confirm_member
    # end

    # def destroy
    #   if @group.destroy
    #     render json: {:message=>"Success"}, status: 200
    #   end
    # end

    private

    def set_group
      @group = Group.find_by_uuid(params[:id])
      unless @group
        render json: {:message=>"No Group Found"}, status: 400 and return
      end
    end

  end
end
