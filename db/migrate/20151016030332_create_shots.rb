class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.text :description
      t.integer :user_id, :index => true

      t.timestamps null: false
    end
  end
end
