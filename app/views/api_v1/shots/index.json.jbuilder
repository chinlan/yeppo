json.metadata do
  json.total Shot.count
end

json.data @shots do |s|
  json.photo s.photo
  json.description s.description
  json.shot_type s.shot_type
  json.tag_list s.tag_list
  json.tag_user s.tag_user
  json.tag_category s.tag_category
  json.likes_count s.likes_count
  json.views_count s.views_count
  

  json.data s.comments do |c|
    json.content c.content
  end


end