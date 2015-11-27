class ChatsController < ApplicationController

  before_action :authenticate_user!

  def index
    @chats = Chat.sort_desc ( Chat.involving(current_user) )
  end

  def create
    if Chat.between(current_user.id,params[:partner_id]).present?
      @chat = Chat.between(current_user.id,params[:partner_id]).first
      redirect_to @chat
    else
      partner = LocalUser.find(params[:partner_id])

      @chat = Chat.new
      @chat.user = current_user
      @chat.partner = partner
      @chat.userRead = true
      @chat.partnerRead = true
      @chat.save
      redirect_to @chat, :notice => "New chat created."
    end


  end

  def show
    @chat = Chat.find(params[:id])

    if @chat.unread?(current_user)
      @chat.mark_as_read(current_user)
      @chat.save
    end

    @partner = interlocutor(@chat)
    @messages = @chat.messages
    @message = Message.new
  end

  private
  def interlocutor(chat)
    current_user == chat.partner ? chat.user : chat.partner
  end
end
