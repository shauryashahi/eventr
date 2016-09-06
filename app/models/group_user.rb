class GroupUser < ApplicationRecord

  EVENT_ATTENDING_CREDIT = 100

  belongs_to :user
  belongs_to :group
  
  validates_presence_of :user_id  
  validates_uniqueness_of :user_id, :scope => :group_id
  enum role: [:member,:admin,:owner]

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

  def user_attended_event
    self.event_attended = true
    self.save
    self.add_user_credits_for_attending_event
  end

  def add_user_credits_for_attending_event
    Credit.create(:description=>"Credit Added for Attending Event #{self.group.fb_event_id}",:eventr_credits=>EVENT_ATTENDING_CREDIT,:user_id=>self.user_id)
  end
end
