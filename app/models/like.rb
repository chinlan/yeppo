class Like < ActiveRecord::Base
  belongs_to :shot, :counter_cache => "likes_count"
  belongs_to :user
end
