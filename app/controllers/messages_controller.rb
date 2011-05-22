class MessagesController < ApplicationController
  layout 'diandi'

  def index
    @messages = Message.all
  end
  
  def new
    @message = Message.new
  end
 
  def create
    @message = Message.new(params[:message])
    @message.sender_id = session[:current_user_id]
    if @message.save
      redirect_to user_url(session[:current_user_id])
    else
      render :action=>:new
    end
   
  end

  def show
    @message = Message.find(params[:id])
  end

  def reply
    @message = Message.new
    @message.reply_to_id = params[:id]
  end

  def send_reply
    original_msg = Message.find(params[:message][:reply_to_id])
    @message = Message.new
    @message.reply_to_id = original_msg.id 
    @message.sender_id =session[:current_user_id]
    @message.receiver_id = original_msg.sender_id
    @message.content = params[:message][:content]
    @message.save
    redirect_to :back
  end

  def destroy
    @message = Message.find(params[:id])
  end

end
