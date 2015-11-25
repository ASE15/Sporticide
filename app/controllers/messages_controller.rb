class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
  end

  def new
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build
  end

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(message_params)
    @message.datetime = Time.now
    @message.sender = current_user
    @message.receiver = @chat.partner
    @message.isRead = false
    @chat.isRead = false
    if @chat.save
      redirect_to @chat, :notice => "Message added"
    else
      redirect_to @chat, :alert => "Could not save message"
    end
  end

  private
  def message_params
    params.require(:message).permit(:text)
  end

end
