json.data @user 
  json.id @user.id
  json.name @user.name
  json.location @user.location
  json.content @user.content
  json.status @user.status
  json.role @user.role
  json.head @user.head.url(:thumb)

  json.shots @user.shots do |s|
    json.photo s.photo
    json.description s.description
    json.shot_type s.shot_type
    
    json.comments s.comments do |c|
      json.content c.content
    end
  end
