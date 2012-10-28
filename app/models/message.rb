class Message < ActiveRecord::Base
  attr_accessible :name, :body, :trigger_id
  belongs_to :trigger
end
