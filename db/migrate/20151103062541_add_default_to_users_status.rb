class AddDefaultToUsersStatus < ActiveRecord::Migration
  def change
    change_column :users, :status, :string, :default => "hide"
  end
end
