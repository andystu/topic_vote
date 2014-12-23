class Vote < ActiveRecord::Base
  belongs_to :topic
  has_many :users
end
