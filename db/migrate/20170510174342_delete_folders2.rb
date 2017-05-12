class DeleteFolders2 < ActiveRecord::Migration[5.0]
  def change
    drop_table :folders
    drop_table :folder_contents
  end
end
