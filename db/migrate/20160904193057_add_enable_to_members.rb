class AddEnableToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :group_users, :enabled, :boolean, :default=>false
  end
end
