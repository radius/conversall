class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :name
      t.integer :campaign_id
      t.string :hashtag
      t.boolean :active

      t.timestamps
    end
  end
end
