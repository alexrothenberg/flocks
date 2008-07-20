require File.dirname(__FILE__) + '/../spec_helper'

describe LinkExtractor do
  
  it 'should find a link in text' do
    text = 'here is something http://www.google.com/something.txt, what do you think'
    LinkExtractor.extract(text).should == ['http://www.google.com/something.txt']
  end

  it 'should find multiple links in text' do
    text = 'here is something http://www.google.com and http://www.yahoo.you.com/index, what do you think'
    LinkExtractor.extract(text).should == ['http://www.google.com', 'http://www.yahoo.you.com/index']
  end

end
