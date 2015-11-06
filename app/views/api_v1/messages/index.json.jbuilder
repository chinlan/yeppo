json.conversation @conversation
  
  

  json.messages @conversation.messages do |m|
    json.body m.body
    json.user_id m.user_id
    json.created_at m.created_at
    json.conversation_id m.conversation_id
  end
