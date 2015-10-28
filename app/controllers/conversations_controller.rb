class ConversationsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @conversations = Conversation.get_mine(current_user.id)
  end

  def create
    @conversation = Conversation.get(params[:sender_id], params[:recipient_id])

    unless @conversation
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(:conversation_id => @conversation.id)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

 
end
