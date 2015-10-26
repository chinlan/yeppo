class AddTaguserToShot < ActiveRecord::Migration
  def change
    add_column :shots, :tag_user_id, :integer
    add_column :shots, :tag_category, :string
  end
end
