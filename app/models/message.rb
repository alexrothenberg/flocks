class Message < ActiveRecord::Base

  belongs_to :channel
  belongs_to :nickname

  named_scope :created, lambda{ |day| { :conditions => ['DATE(created_at)=DATE(?)', day] }}
  named_scope :descending, :order => 'created_at DESC'

  validates_presence_of :nickname
  validates_presence_of :channel
  
  def links
    LinkExtractor.extract(message)
  end
  
  def self.links_from(records)
    #REFACTOR: Not a big fan of making this a class method, i feel it breaks encapsulation
    records.map(&:links).flatten
  end
  
end
