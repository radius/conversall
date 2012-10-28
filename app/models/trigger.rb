class Trigger < ActiveRecord::Base
  attr_accessible :name, :active, :campaign_id, :hashtag
  belongs_to :campaign
  has_many :messages
  has_many :coupon_codes
end
