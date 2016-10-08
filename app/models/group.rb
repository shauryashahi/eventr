class Group < ApplicationRecord

  has_many :members, :class_name => "::GroupUser", :foreign_key => :group_id, dependent: :destroy
  has_many :users, :through => :members

  validates_presence_of :owner_id, :fb_event_id, :name
  validates_uniqueness_of :name, :scope => :fb_event_id
  validate :check_if_owner_already_in_event_group, :on => :create

  accepts_nested_attributes_for :members,:reject_if => :check_dup_entry, :allow_destroy => true
  
  before_create :create_group_on_sendbird  
  after_create :add_owner_to_group, :fetch_event_details_from_fb


  def check_if_owner_already_in_event_group
    current_event_id = self.fb_event_id
    attending_event_ids = self.owner.groups.pluck(:fb_event_id)
    if attending_event_ids.include?current_event_id
      self.errors.add(:base,"You are already going to the event with another group.")
      return false
    else
      return true
    end
  end

  def create_group_on_sendbird
    url = URI.parse("https://api.sendbird.com/v3/group_channels")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["api-token"] = "#{ENV["SENDBIRD_APP_TOKEN"]}"
    request.body = "{\"user_ids\":[\"#{self.owner.uuid}\"],\"name\":\"#{self.name+self.fb_event_id}\"}"
    response = http.request(request)
    data = JSON.parse(response.body)
    self.update_attributes(:channel_url => data["channel_url"]) if response.code == "200"
  end

  def fetch_event_details_from_fb
    message, code, data = self.owner.fetch_fb_event(self.fb_event_id)
    start_time = data["start_time"].to_time
    (data["end_time"].nil?)? end_time = start_time + 1.day : end_time = data["end_time"].to_time
    name = data["name"]
    self.update_attributes(:event_name=>name, :event_start_time => start_time, :event_end_time => end_time)
  end
  
  def add_owner_to_group
    owner = self.members.new({:group_id=>self.id,:user_id=>self.owner_id,:role=>2,:enabled=>true,:state=>1})
    owner.save
  end

  def check_dup_entry(attributed)
    return true if ::GroupUser.find_by(:user_id=>attributed[:user_id],:group_id=>self.id)
    false
  end

  def owner
    ::User.find_by(:id=>self.owner_id)
  end
end
