class Group < ApplicationRecord

  has_many :members, :class_name => "::GroupUser", :foreign_key => :group_id, dependent: :destroy
  has_many :users, :through => :members

  validates_presence_of :admin_id, :fb_event_id

  accepts_nested_attributes_for :members,:reject_if => :check_dup_entry, :allow_destroy => true
  
  after_create :add_admin_to_group

  def add_admin_to_group
    self.members.create({:group_id=>self.id,:user_id=>self.admin_id})
  end

  def check_dup_entry(attributed)
    return true if ::GroupUser.find_by(:user_id=>attributed[:user_id],:group_id=>self.id)
    false
  end

  def admin
    ::User.find_by(:id=>self.admin_id)
  end
end
