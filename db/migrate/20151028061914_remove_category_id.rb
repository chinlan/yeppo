class RemoveCategoryId < ActiveRecord::Migration
  def change
    remove_column :shots, :category_id, :integer
  end
end
