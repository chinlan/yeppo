class ApiV1::ConversationsController < ApiController

  def index
    if authenticate_user_from_token!
       @conversations = Conversation.all
    else
      render :json => { :message => "auth_token failed"}, :status => 400
    end
  end

  def create
    if authenticate_user_from_token!
       if Conversation.between(params[:sender_id], params[:recipient_id]).present?
          @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
       else
          @conversation = Conversation.create!(conversation_params)
       end
  
       render :json => { :message => "Success", :id=> @conversation.id }
    else
       render :json => {:message => "auth_token failed"}, :status => 400
    end
  end


  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
