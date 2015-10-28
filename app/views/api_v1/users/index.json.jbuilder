json.metadata do
  json.total User.count
end

json.users @users do |u|
  json.id u.id
  json.name u.name
  json.location u.location
  json.content u.content
  json.status u.status
  json.role u.role
  json.head u.head

  json.shots u.shots do |s|
    json.photo s.photo
    json.description s.description
    json.shot_type s.shot_type
    
    json.comments s.comments do |c|
      json.content c.content
    end
  end
end