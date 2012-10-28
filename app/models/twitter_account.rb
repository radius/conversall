class TwitterAccount < ActiveRecord::Base
  attr_accessible :name, :access_token, :access_token_secret, :consumer_key, :consumer_secret, :description, :handle
  has_many :campaigns
end
