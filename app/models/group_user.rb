class GroupUser < ApplicationRecord

  EVENT_ATTENDING_CREDIT = 100

  belongs_to :user
  belongs_to :group
  
  validates_presence_of :user_id  
  validates_uniqueness_of :user_id, :scope => :group_id
  enum role: [:member,:admin,:owner]
  enum state: [:requested, :approved, :declined]

  validate :check_if_user_already_in_event_group, :on => :create

  def check_if_user_already_in_event_group
    current_event_id = self.group.fb_event_id
    attending_event_ids = self.user.groups.pluck(:fb_event_id)
    if attending_event_ids.include?current_event_id
      self.errors.add(:base,"You are already going to the event with another group.")
      return false
    else
      return true
    end
  end

  def add_member_to_sendbird_group
    url = URI.parse("https://api.sendbird.com/v3/group_channels/#{self.group.channel_url}/invite")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["api-token"] =  "#{ENV["SENDBIRD_APP_TOKEN"]}"
    request.body = "{\"user_ids\":[\"#{self.user.uuid}\"]}"
    response = http.request(request)
    data = JSON.parse(response.body)
  end

  def user_attended_event
    self.event_attended = true
    self.save
    self.add_user_credits_for_attending_event
  end

  def confirm_approval state
    (state==1)? self.enabled = true : self.enabled = false
    self.state = state
    self.save
    self.add_member_to_sendbird_group
  end

  def add_user_credits_for_attending_event
    Credit.create(:for_fb_event_id => "#{self.group.fb_event_id}",:description=>"Credit Added for Attending Event #{self.group.fb_event_id}-#{self.group.event_name} by #{self.group.owner.name}",:eventr_credits=>EVENT_ATTENDING_CREDIT,:user_id=>self.user_id)
  end
end
