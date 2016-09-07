class Credit < ApplicationRecord
  belongs_to :user

  validate :should_only_be_added_once_per_event, :on => :create

  def should_only_be_added_once_per_event
    current_event_id = self.for_fb_event_id
    credited_event_ids = self.user.credits.pluck(:for_fb_event_id)
    if credited_event_ids.include?current_event_id
      self.errors.add(:base,"Credit for this event has already been added.")
      return false
    else
      return true
    end
  end
end
