class MessagesController < ApplicationController

  before_action :find_conversation, :authenticate_user!

  def index
    @messages = @conversation.messages.includes(:user).order("id DESC")

    if params[:m]
      @over_ten = false
    else
      @messages = @messages.limit(10)
      @over_ten = @conversation.messages.count > 10
    end

    last_to_me_message = @conversation.find_last_to_me_message(current_user)
    if last_to_me_message && !last_to_me_message.read
        last_to_me_message.read = true
        last_to_me_message.save!
    end

     @message = @conversation.messages.new

     # respond_to :html, :js
   end

   def new 
    @message = @conversation.messages.new
   end

   def create
    @message = @conversation.messages.new(message_params)

    if @message.save
      respond_to do |format|
        format.html{ redirect_to conversation_messages_path(@conversation) }
        format.js
      end
    else
      redirect_to conversation_messages_path(@conversation)
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
