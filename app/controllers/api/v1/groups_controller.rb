module Api::V1
  class GroupsController < ApiController
    before_action :set_group, only: [:group_members, :destroy, :confirm_member, :join_group, :invite_members, :make_admin,:mark_attendance]

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
      render json: {:data=>build_members(@group),:message=>"Success"}, status: 200
    end

    def create
      group = Group.new(group_params)
      group.owner_id = @current_user.id
      if group.save
        render json: {:data=>group.reload.attributes, :message=>"Success"}, status: 200
      else
        render json: {:data=>{},:message=>"#{group.errors.full_messages}"}, status: 400
      end
    end

    def invite_members
    end

    def join_group
      member = @group.members.new({:group_id=>@group.id,:user_id=>@current_user.id})
      if member.save
        render json: {:data => build_members(@group),:message=>"Success"}, status: 200
      else
        render json: {:data=>{}, :message=>"#{member.errors.full_messages}"}, status: 400
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

    def build_members group
      members_array = Array.new
      group.members.each do |mem|
        data = Hash.new
        usr = mem.user
        data["id"] = usr.id
        data["user_uuid"] = usr.uuid
        data["member_uuid"] = mem.uuid
        data["fb_id"] = usr.fb_id
        data["name"] = usr.name
        data["email"] = usr.email
        data["role"] = mem.role
        data["enabled"] = mem.enabled
        data["pic_url"] = usr.pic_url
        data["event_attended"] = mem.event_attended
        members_array << data
      end
      members_array
    end

  end
end
