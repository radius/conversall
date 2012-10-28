class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :brand_id
      t.integer :twitter_account_id

      t.timestamps
    end
  end
end
