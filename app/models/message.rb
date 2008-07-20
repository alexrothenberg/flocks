class Message < ActiveRecord::Base
  
  belongs_to :channel
  belongs_to :nickname

  named_scope :created, lambda{ |day| { :conditions => ['DATE(created_at)=DATE(?)', day] }}
  named_scope :descending, :order => 'created_at DESC'

  validates_presence_of :nickname
  validates_presence_of :channel
  
end
