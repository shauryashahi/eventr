class GroupUser < ApplicationRecord

  belongs_to :user
  belongs_to :group
  
  validates_presence_of :user_id  
  validates_uniqueness_of :user_id, :scope => :group_id
  enum role: [:member,:admin,:owner]
end
