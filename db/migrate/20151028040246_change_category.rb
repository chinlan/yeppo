class ChangeCategory < ActiveRecord::Migration
  
  def change
    add_column :shots, :shot_type, :string, :null => false

    # after fix data:
    #  remove_column :shots, :category_id
    #  drop_table :categories
  end

end
