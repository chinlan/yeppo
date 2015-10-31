class MessagesController < ApplicationController

  before_action :find_conversation, :authenticate_user!

  

   def new 
    @message = @conversation.messages.new
   end

   def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      respond_to do |format|
        format.html{ redirect_to conversations_path }
        format.js
      end
    else
      redirect_to conversations_path
    end
   end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end


  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  
end
