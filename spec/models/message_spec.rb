require File.dirname(__FILE__) + '/../spec_helper'

describe Message do

  it 'should always have a nickname' do
    message = create!(Message, :nickname_id => nil)
    message.should_not be_valid?
    message.errors.on(:nickname).should_not be_nil
  end
  
end