class User < ApplicationRecord

  has_many :user_groups, :class_name => "::GroupUser", :foreign_key => :user_id, dependent: :destroy
  has_many :groups, :through => :user_groups

  after_save :get_longlived_token

  ALLOWED_RSVP_STATES = ["attending","declined","maybe","not_replied","created"]

  def get_longlived_token
    url = URI.parse("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=#{ENV["FB_APP_ID"]}&client_secret=#{ENV["FB_APP_SECRET"]}&fb_exchange_token=#{self.fb_token}")
    response = Net::HTTP.get_response(url)
    if response.code == "200"
      parameters = Rack::Utils.parse_nested_query(response.body)
      long_token = parameters["access_token"]
      self.update_columns(:fb_token => long_token)
    end
  end 

  def logout access_token
    Redis.current.del("user:token:#{access_token}")
  end  

  def self.login_with_facebook token
    user = get_facebook_data token
    if user
      auth_token = create_access_token user.uuid
      return true, user, auth_token
    else
      return false, nil, nil
    end      
  end  

  def fetch_fb_event_list rsvp_state
    if ALLOWED_RSVP_STATES.include?rsvp_state
      url = "https://graph.facebook.com/v2.7/#{self.fb_id}/events/#{rsvp_state}?fields=id,name,cover,is_canceled,attending_count,maybe_count,interested_count,start_time&access_token=#{self.fb_token}"
      fb_api_call url
    else
      return "Please check the RSVP status of the event.", {}, 400
    end
  end

  def fetch_fb_event fb_event_id
    url = "https://graph.facebook.com/v2.7/#{fb_event_id}?fields=id,name,cover,description,place,is_canceled,is_viewer_admin,attending_count,maybe_count,interested_count,noreply_count,declined_count,owner,ticket_uri,start_time,end_time,timezone&access_token=#{self.fb_token}"
    fb_api_call url
  end

  def self.get_facebook_data token
    response = Net::HTTP.get_response(URI.parse("https://graph.facebook.com/v2.7/me?fields=name,email,picture.width(400)&access_token=#{token}"))
    data = JSON.parse(response.body)
    if response.code=="200"
      data["token"] = token
      self.create_user data 
    end
  end 

  def self.create_user data 
    user = self.find_or_initialize_by(:fb_id => data["id"])
    user.update_attributes(self.user_params(data))
    user.reload
  end  

  def self.create_access_token uuid
    access_token = SecureRandom.hex(16)
    Redis.current.set("user:token:#{access_token}", uuid)
    access_token
  end

  def self.get_user_from_token token
    uuid = Redis.current.get("user:token:#{token}")
    user = User.find_by_uuid(uuid) rescue nil
  end

    private

    def self.user_params data
      {
        :fb_id => data["id"],
        :email => data["email"],
        :pic_url => (data["picture"]["data"]["url"] rescue nil),
        :fb_token => data["token"],
        :name => data["name"]
      }
    end

    def fb_api_call url
      response = Net::HTTP.get_response(URI.parse(url))
      data = JSON.parse(response.body)
      (response.code=="200")? message="Success": message=data["error"]["type"]
      return message, response.code, data
    end

end
