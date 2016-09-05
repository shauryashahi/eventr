class AddAttentedToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :event_attended, :boolean, :default=>false
  end
end
