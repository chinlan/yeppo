class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :shot_id, :index => true

      t.timestamps null: false
    end
  end
end
