class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :shot

  validates_presence_of :content
end
