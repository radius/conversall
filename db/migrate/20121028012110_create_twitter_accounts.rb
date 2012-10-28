class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :name
      t.string :handle
      t.text :description
      t.string :consumer_key
      t.string :consumer_secret
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end
end
