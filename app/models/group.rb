class Group < ApplicationRecord

  has_many :members, :class_name => "::GroupUser", :foreign_key => :group_id, dependent: :destroy
  has_many :users, :through => :members

  validates_presence_of :owner_id, :fb_event_id
  validates_uniqueness_of :name, :scope => :fb_event_id
  validate :check_if_owner_already_in_event_group, :on => :create

  accepts_nested_attributes_for :members,:reject_if => :check_dup_entry, :allow_destroy => true
  
  after_create :add_owner_to_group


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
  
  def add_owner_to_group
    owner = self.members.new({:group_id=>self.id,:user_id=>self.owner_id,:role=>2,:enabled=>true})
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
