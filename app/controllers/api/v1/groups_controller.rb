module Api::V1
  class GroupsController < ApiController
    before_action :set_group, only: [:group_members, :destroy, :confirm_member, :join_group, :invite_members]

    def event_groups
      if params[:fb_event_id].present?
        groups = Group.where(:fb_event_id=>params[:fb_event_id])
        my_group = @current_user.groups.find_by(:fb_event_id=>params[:fb_event_id])
        data = {:groups=>groups.as_json,:my_group=>my_group.as_json}
        render json: {:data=>data,:message => "Success"}, status: 200
      else
        render json: {:message => "Cannot find FB Event ID. Check Input Parameters."}, status: 400
      end
    end

    def user_groups
      render json: {:data=>@current_user.groups.as_json,:message=>"Success"}, status: 200
    end

    def group_members
      render json: {:data=>@group.users.except(:fb_token).as_json,:message=>"Success"}, status: 200
    end

    def create
      group = Group.new(group_params)
      group.owner_id = @current_user.id
      if group.save
        render json: {:data=>@group.attributes, :message=>"Success"}, status: 200
      else
        render json: {:data=>{},:message=>"#{group.errors.full_messages}"}, status: 400
      end
    end

    def invite_members
    end

    def join_group
    end

    def confirm_member
    end

    def destroy
      if @group.destroy
        render json: {:message=>"Success"}, status: 200
      else
        render json: {:message=>"#{@group.errors.full_messages}"}, status: 400
      end
    end

    private

    def set_group
      @group = Group.find_by_uuid(params[:id])
      unless @group
        render json: {:message=>"No Group Found"}, status: 400 and return
      end
    end

    def group_params
      params.require(:group).permit(:fb_event_id,:name)
    end

  end
end
