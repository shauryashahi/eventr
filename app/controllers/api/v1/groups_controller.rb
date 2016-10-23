module Api::V1
  class GroupsController < ApiController
    before_action :set_group, only: [:group_members, :destroy, :confirm_member, :join_group, :send_invite, :make_admin,:mark_attendance]

    def event_groups
      if params[:fb_event_id].present?
        groups = Group.where(:fb_event_id=>params[:fb_event_id])
        my_group = @current_user.groups.find_by(:fb_event_id=>params[:fb_event_id])
        data = {:groups=>build_groups(groups),:my_group=>build_group_hash(my_group)}
        render json: {:data=>data,:message => "Success"}, status: 200
      else
        render json: {:message => "Cannot find FB Event ID. Check Input Parameters."}, status: 400
      end
    end

    def user_groups
      render json: {:data=>build_groups(@current_user.groups),:message=>"Success"}, status: 200
    end

    def group_members
      render json: {:data=>build_members(@group),:message=>"Success"}, status: 200
    end

    def create
      group = Group.new(group_params)
      group.owner_id = @current_user.id
      if group.save
        render json: {:data=>build_group_hash(group.reload), :message=>"Success"}, status: 200
      else
        render json: {:data=>{},:message=>"#{group.errors.full_messages}"}, status: 400
      end
    end

    def join_group
      member = @group.members.new({:group_id=>@group.id,:user_id=>@current_user.id})
      if member.save
        render json: {:data => build_members(@group),:message=>"Success"}, status: 200
      else
        render json: {:data=>{}, :message=>"#{member.errors.full_messages}"}, status: 400
      end
    end

    def join_group_with_invite_code
      group = Group.find_by_invite_code(params[:invite_code])
      if group
        if Time.now > group.event_end_time
          render json: {:data=>{},:message=>"This event has ended."}, status: 400
        else
          member = group.members.new({:group_id=>group.id,:user_id=>@current_user.id})
          fb_message, fb_code, fb_data = @current_user.rsvp_event(group.fb_event_id, "attending")
          if fb_code=="200"
            if member.save
              render json: {:data => build_members(group),:message=>"Success"}, status: 200
            else
              render json: {:data=>{}, :message=>"#{member.errors.full_messages}"}, status: 400
            end
          else
            render json: {:data=>{},:message=>"#{fb_data["error"]["type"]}"}, status: 400
          end
        end
      else
        render json: {:data =>{}, :message=>"No Active Group Found"}, status: 400
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
        data = build_member_hash(mem)
        members_array << data
      end
      members_array
    end

    def build_member_hash member
      data = Hash.new
      usr = member.user
      data["id"] = usr.id
      data["user_uuid"] = usr.uuid
      data["member_uuid"] = member.uuid
      data["fb_id"] = usr.fb_id
      data["name"] = usr.name
      data["email"] = usr.email
      data["role"] = member.role
      data["enabled"] = member.enabled
      data["status"] = member.state
      data["pic_url"] = usr.pic_url
      data["event_attended"] = member.event_attended
      data
    end

    def build_groups groups
      groups_array = Array.new
      groups.each do |grp|
        data = build_group_hash(grp)
        groups_array << data
      end
      groups_array
    end

    def build_group_hash group
      unless group.nil? 
        data = group.attributes
        data["is_event_over"] = (Time.now > group.event_end_time rescue false)
        curr_member = GroupUser.find_by(:user_id=>@current_user.id,:group_id=>group.id)
        data["current_user_group_status"] = curr_member.state rescue "not_requested"
        data["is_current_user_member"] = curr_member.role? rescue false
        data["is_current_user_owner"] = (curr_member.role=="owner") rescue false
        data["is_current_user_admin"] = (curr_member.role=="admin" || curr_member.role=="owner") rescue false
        (params[:request_source]=="ios")? link = "https://apple.com": link = "https://playstore.com"
        data["invite_text"]="Hi, come join my Group on Eventr. Here's the invitation code - #{group.invite_code}. Download the app now from #{link}"
      else
        data = {}
      end
      data
    end
  end
end
