class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :fb_event_id
      t.string :name
      t.integer :admin_id
      t.uuid :uuid, default: "uuid_generate_v4()"
      t.timestamps
    end

  end
end
