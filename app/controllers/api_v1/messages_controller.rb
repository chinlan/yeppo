class ApiV1::MessagesController < ApiController
  
  before_action :authenticate_user!
  before_action :find_conversation

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
       render :json => { :message => "Successfully created", :id => @message.id }
    else
       render :json => { :message => "Validate failed" }, :status => 400
    end
  end

  private

  def message_params
    params.permit(:body, :user_id)
  end


  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
