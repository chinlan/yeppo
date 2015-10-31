class AddFriendlyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendly_id, :string
    add_index :users, :friendly_id, unique: true
  end
end
