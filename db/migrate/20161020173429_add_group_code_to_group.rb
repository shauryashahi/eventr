class AddGroupCodeToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :invite_code, :string
  end
end
