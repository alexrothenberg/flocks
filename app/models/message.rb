class Message < ActiveRecord::Base

  belongs_to :channel
  belongs_to :nickname

  named_scope :created, lambda{ |day| { :conditions => ['DATE(created_at)=DATE(?)', day] }}
  named_scope :descending, :order => 'created_at DESC'

  validates_presence_of :nickname
  validates_presence_of :channel
  
  class << self
    def any_after?(date)
      find(:first, :order => 'created_at DESC', :limit => 1).created_at >= (date + 1.day)
    end

    def any_before?(date)
      find(:first, :order => 'created_at ASC', :limit => 1).created_at <= date
    end

    #REFACTOR: Not a big fan of making this a class method, i feel it breaks encapsulation
    def links_from(records)
      records.map(&:links).flatten
    end    
  end
  
  def links
    LinkExtractor.extract(message)
  end
    
end
