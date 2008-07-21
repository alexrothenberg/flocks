class MessagesController < ApplicationController
  
  def index
    if params[:channel_id]
      @channel = Channel.find(params[:channel_id])
      @date = Date.today
      @date = Date.parse([params[:year], params[:month], params[:day]].join('/')) if params[:year] && params[:month] && params[:day]
      @messages = @channel.messages.created(@date).descending      
      flash[:message] = "Here are all the messages for #{@channel.name} on #{@date}"
    elsif params[:nickname_id]
      @nickname = Nickname.find(params[:nickname_id])
      @messages = @nickname.messages.descending
      flash[:message] = "Here are all the messages #{@nickname.name} has posted"
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to :back
  end
  
end
