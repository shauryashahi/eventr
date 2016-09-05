class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :eventr_credits
      t.string :description
      t.timestamps
    end
  end
end
