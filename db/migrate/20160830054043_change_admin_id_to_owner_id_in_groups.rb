class ChangeAdminIdToOwnerIdInGroups < ActiveRecord::Migration[5.0]
  def change
    rename_column :groups, :admin_id, :owner_id
  end
end
