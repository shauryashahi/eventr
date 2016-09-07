class AddStateToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :state, :integer, :default => 0
  end
end
