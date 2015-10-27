json.metadata do
  json.total Conversation.count
end

json.data @conversations do |c|
  
  json.data c.messages do |m|
    json.body m.body
    json.created_at m.created_at
    json.user_id m.user_id
    json.read m.read
    json.conversation_id m.conversation_id
  end


end