class Campaign < ActiveRecord::Base
  attr_accessible :name, :brand_id, :twitter_account_id
  belongs_to :brand
  belongs_to :twitter_account
  has_many :triggers  
end
