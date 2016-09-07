class AddEventIDforCredit < ActiveRecord::Migration[5.0]
  def change
    add_column :credits, :for_fb_event_id, :string
  end
end
