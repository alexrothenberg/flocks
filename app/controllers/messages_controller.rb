class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
  end

  #FIX: Stupid Hack to fix eventually when i get a better date controller
  def create
    if params[:date]
      date = Date.parse(params[:date])
      redirect_to message_by_date_url(:channel_id => params[:channel_id], 
                                      :month => date.month,
                                      :year => date.year,
                                      :day => date.day)
    else
      redirect_to :back
    end
  end
  
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
