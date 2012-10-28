class Brand < ActiveRecord::Base
  attr_accessible :logo, :name
  has_many :campaigns, :dependent => :destroy
end
