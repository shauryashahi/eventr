class User < ApplicationRecord

  has_many :user_groups, :class_name => "::GroupUser", :foreign_key => :user_id, dependent: :destroy
  has_many :groups, :through => :user_groups

  after_create :get_longlived_token

  def get_longlived_token
    url = URI.parse("https://graph.facebook.com/oauth/access_token?grant_type=fb_exchange_token&client_id=#{ENV["FB_APP_ID"]}&client_secret=#{ENV["FB_APP_SECRET"]}&fb_exchange_token=#{self.fb_token}")
    response = Net::HTTP.get_response(url)
    # TODO Response from FB is 400, longlived token is not being saved
    if response.code == "200"
      parameters = Rack::Utils.parse_nested_query(response.body)
      long_token = parameters["access_token"]
      self.update_columns(:fb_token => long_token)
    end
  end

  def self.get_facebook_data token
    url = "https://graph.facebook.com/v2.4/me?fields=name,email,birthday,picture.width(400)&access_token=#{token}"
    response = Net::HTTP.get_response(URI.parse(url)) 
    if response.code == "200"
      data = JSON.parse(response.body)
      data["token"] = token
      user = self.create_user data
      return user
    end  
  end  

  def self.create_user data 
    user = self.find_or_initialize_by(:fb_id => data["id"])
    user.update_attributes(self.user_params(data))
    user.reload
  end  

  def self.login_with_facebook token
    user = self.get_facebook_data token
    if user
      auth_token = self.create_access_token user.uuid
      return true, user, auth_token
    else
      return false, nil, nil
    end      
  end  

  def self.user_params data
    {
      :fb_id => data["id"],
      :email => data["email"],
      :pic_url => (data["picture"]["data"]["url"] rescue nil),
      :fb_token => data["token"],
      :name => data["name"]
    }
  end


  # TODO INSTALL AND SET REDIS

  def self.create_access_token uuid
    # access_token = SecureRandom.hex(16)
    # Redis.current.set("user:token:#{access_token}", uuid)
    # access_token
  end

  def logout access_token
    # Redis.current.del("user:token:#{access_token}")
  end  

  def self.get_user_from_token token
    # uuid = Redis.current.get("user:token:#{token}")
    # user = User.find_by_uuid(uuid) rescue nil
  end

end
