class CouponCode < ActiveRecord::Base
  attr_accessible :name, :delivered, :sent, :sent_to, :trigger_id, :value
  belongs_to :trigger
end
