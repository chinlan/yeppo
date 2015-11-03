class ApiV1::MessagesController < ApiController
  
  

  def create
     if authenticate_user_from_token!
        @message = @conversation.messages.new(message_params)
        if @message.save
           render :json => { :message => "Successfully created", :id => @message.id }
        else
           render :json => { :message => "Validate failed" }, :status => 400
        end
     else 
        render :json => { :message => "auth_token failed"}, :status => 400
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
