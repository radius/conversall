class CreateCouponCodes < ActiveRecord::Migration
  def change
    create_table :coupon_codes do |t|
      t.string :name
      t.integer :trigger_id
      t.string :value
      t.boolean :sent
      t.string :sent_to
      t.boolean :delivered

      t.timestamps
    end
  end
end
