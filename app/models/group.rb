class Group < ApplicationRecord

  has_many :members, :class_name => "::GroupUser", :foreign_key => :group_id, dependent: :destroy
  has_many :users, :through => :members

  validates_presence_of :owner_id, :fb_event_id
  validates_uniqueness_of :name, :scope => :fb_event_id

  accepts_nested_attributes_for :members,:reject_if => :check_dup_entry, :allow_destroy => true
  
  after_create :add_owner_to_group

  def add_owner_to_group
    self.members.create({:group_id=>self.id,:user_id=>self.owner_id,:role=>2,:enabled=>true})
  end

  def check_dup_entry(attributed)
    return true if ::GroupUser.find_by(:user_id=>attributed[:user_id],:group_id=>self.id)
    false
  end

  def owner
    ::User.find_by(:id=>self.owner_id)
  end
end
