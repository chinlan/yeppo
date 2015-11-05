class ApiV1::ConversationsController < ApiController

  before_action :authenticate_user!
  
  def index
       @conversations = Conversation.all
  end

  def create
       if Conversation.between(params[:sender_id], params[:recipient_id]).present?
          @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
       else
          @conversation = Conversation.create!(conversation_params)
       end
  
       render :json => { :message => "Success", :id=> @conversation.id }
  end


  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
