class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fb_id
      t.string :name
      t.string :email
      t.uuid :uuid, default: "uuid_generate_v4()"
      t.date :birthday
      t.string :pic_url
      t.text :fb_token
      t.timestamps
    end
  end
end
