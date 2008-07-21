xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(@channel.name)
    xml.link(channel_url(@channel))
    xml.description(flash[:message])
    xml.language('en-us')
      for message in @messages
        xml.item do
          xml.title(message.message)
          # xml.description(post.html_content)      
          xml.author(message.nickname.name)               
          xml.pubDate(message.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(message_url(message))
          xml.guid(message_url(message))
        end
      end
  }
}