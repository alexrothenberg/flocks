class Nickname < ActiveRecord::Base
  has_many :messages
end
