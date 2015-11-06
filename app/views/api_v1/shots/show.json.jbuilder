

json.shot @shot
  json.photo @shot.photo
  json.description @shot.description
  json.shot_type @shot.shot_type
  json.tag_list @shot.tag_list
  json.tag_user @shot.tag_user
  json.tag_category @shot.tag_category
  json.likes_count @shot.likes_count
  json.views_count @shot.views_count
  

  json.comments @shot.comments do |c|
    json.content c.content
    json.user_id c.user_id
    json.created_at c.created_at
    json.shot_id c.shot_id
  end


