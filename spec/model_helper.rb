module ModelHelper

  def new!(model, differences={})
    params = send("#{model.name.underscore}_params").merge(differences)
    model.new(params)
  end

  def create!(model, differences={})
    params = send("#{model.name.underscore}_params").merge(differences)
    begin
      model.create!(params)
    rescue Exception => error
      raise "Error '#{error}' creating #{model} with params: #{params.inspect}"
    end
  end

  def next_integer
    (@integer ||= 0) && @integer += 1
  end
  
  def random_text(length=nil)
    length = rand(1000) if length.nil?
    chars = ' abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789   '
    text = ''
    length.downto(1) { |i| text << chars[rand(chars.length - 1)] }
    text
  end
  
  def nickname_params
    {
      :name => "USER_#{next_integer}"
    }
  end
  
  def message_params
    {
      :message => random_text,
      :nickname_id => create!(Nickname).id,
      :channel_id => create!(Channel).id
    }
  end
  
  def channel_params
    {
      :nickname => "BOT_#{next_integer}",
      :name => "Channel_#{next_integer}",
      :server => "irc.freenode.net", 
      :port => '6667'
    }
  end
  
end