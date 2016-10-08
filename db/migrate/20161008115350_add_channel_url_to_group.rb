class AddChannelUrlToGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :channel_url, :string
  end
end
