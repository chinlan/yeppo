class AddHeadToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :head
  end
end
