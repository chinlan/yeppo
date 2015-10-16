class AddViewsCountToShots < ActiveRecord::Migration
  def change
    add_column :shots, :views_count, :integer,:default => 0
  end
end
