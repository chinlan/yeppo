class MessagesController < ApplicationController

  before_action :find_conversation

  def index
    @messages = @conversation.messages.includes(:user).order("id DESC")

    if params[:m]
      @over_ten = false
    else
      @messages = @messages.limit(10)
      @over_ten = @conversation.messages.count > 10
    end

    if @messages.last
       if @messages.last.user != current_user
          @messages.last.read = true
       end
    end

     @message = @conversation.messages.new
   end

   def new 
    @message = @conversation.messages.new
   end

   def create
    @message = @conversation.messages.new(message_params)

    if @message.save
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
