class AddIsEventOverFeatureToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :event_end_time, :datetime
    add_column :groups, :event_start_time, :datetime
    add_column :groups, :event_name, :string
  end
end
