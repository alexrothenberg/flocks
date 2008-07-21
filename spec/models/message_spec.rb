require File.dirname(__FILE__) + '/../spec_helper'

describe Message do

  it 'should always have a nickname' do
    message = new!(Message, :nickname_id => nil)
    message.should_not be_valid
    message.errors.on(:nickname).should_not be_nil
  end

  it 'should always have a channel' do
    message = new!(Message, :channel_id => nil)
    message.should_not be_valid
    message.errors.on(:channel).should_not be_nil    
  end
  
  it 'should order messages by newest message first' do
    message_1 = create!(Message)
    message_2 = create!(Message)
    message_2.update_attribute(:created_at, 2.days.ago)
    
    Message.descending.all.first.should == message_1
  end
  
  it 'should find links in message' do
    message = create!(Message, :message => 'here is something http://www.google.com/something.txt, what do you think')
    message.links.should == ['http://www.google.com/something.txt']
  end
  
  it 'should find all the links in a list of messages' do
    create!(Message, :message => 'here is something: http://www.google.com')
    create!(Message, :message => 'here is something else: http://www.yahoo.com')
    Message.links_from(Message.all).should == ['http://www.google.com', 'http://www.yahoo.com']
  end
  
  it 'should indicate if there messages after a given date' do
    message = create!(Message)
    message.update_attribute(:created_at, Date.today)    
    Message.any_after?(Date.today).should be_false
    
    new_message_tomorrow = create!(Message)
    new_message_tomorrow.update_attribute(:created_at, 1.day.from_now)
    Message.any_after?(Date.today).should be_true
  end

  it 'should indicate if there messages before a given date' do
    message = create!(Message)
    message.update_attribute(:created_at, Date.today)    
    Message.any_before?(Date.today).should be_false
    
    message_yesterday = create!(Message)
    message_yesterday.update_attribute(:created_at, 2.day.ago)
    Message.any_before?(Date.today).should be_true
  end
  
end