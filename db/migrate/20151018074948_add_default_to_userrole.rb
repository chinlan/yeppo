class AddDefaultToUserrole < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, :default => "normal"
    change_column :shots, :likes_count, :integer, :default => 0
  end
end
