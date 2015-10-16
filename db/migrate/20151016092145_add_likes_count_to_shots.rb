class AddLikesCountToShots < ActiveRecord::Migration
  def change
    add_column :shots, :likes_count, :integer
  end
end
