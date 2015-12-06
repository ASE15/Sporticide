class MessagesController < ApplicationController

  before_action :authenticate_user!

  def show
    @message = Message.find(params[:id])
    if not @message.chat.involved?(current_user)
      redirect_to chats_path, :error => "This is not your chat!"
    else
      @message = Message.find(params[:id])
    end
  end

  def new
    @chat = Chat.find(params[:chat_id])

    if not @chat.involved?(current_user)
      redirect_to chats_path, :error => "This is not your chat!"
    else
      @message = @chat.messages.build
    end
  end

  def create
    @chat = Chat.find(params[:chat_id])

    if not @chat.involved?(current_user)
      redirect_to chats_path, :error => "This is not your chat!"
    else

      @message = @chat.messages.build(message_params)
      @message.datetime = Time.now
      @message.user = current_user
      @chat.unread_partner_of(current_user)
      if @chat.save
        redirect_to @chat, :notice => "Message added"
      else
        redirect_to @chat, :alert => "Could not save message"
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:text)
  end

end
