class AddPaperclickToShots < ActiveRecord::Migration
  def change
    add_attachment :shots, :photo
  end
end
