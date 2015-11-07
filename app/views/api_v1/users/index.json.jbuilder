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
  json.head u.head.url(:medium)


  json.shots u.shots do |s|
    json.photo s.photo.url(:large)
    json.photo s.photo.url(:medium)
    json.description s.description
    json.shot_type s.shot_type
    json.created_at s.created_at
    json.updated_at s.updated_at
    json.likes_count s.likes_count
    json.views_count s.views_count

    
    json.comments s.comments do |c|
      json.content c.content
      json.created_at c.created_at
    end
  end
end