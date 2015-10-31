class ConversationsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.get_mine(current_user.id)
    if params[:conversation_id]
      @conversation = Conversation.find(params[:conversation_id])
       @messages = @conversation.messages.includes(:user).order("id DESC").limit(10)

      @message = @conversation.messages.new
    end    
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.includes(:user).order("id DESC").limit(10)
    @message = @conversation.messages.new
       
    last_to_me_message = @conversation.find_last_to_me_message(current_user)
    if last_to_me_message && !last_to_me_message.read
        last_to_me_message.read = true
        last_to_me_message.save!
    end

    respond_to :js
  end

  def create
    @conversation = Conversation.get(params[:sender_id], params[:recipient_id])

    unless @conversation
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversations_path(:conversation_id => @conversation.id)
  end

  def more_messages
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.offset(10)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

 
end
