class AddRolesToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :role, :integer, :default=>0
  end
end
