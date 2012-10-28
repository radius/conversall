class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.integer :trigger_id
      t.text :body

      t.timestamps
    end
  end
end
