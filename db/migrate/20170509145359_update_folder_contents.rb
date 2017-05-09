class UpdateFolderContents < ActiveRecord::Migration[5.0]
  def change
    create_table :folders do |t|
      t.integer :folder_id
      t.integer :content_id
      t.timestamps null: false
    end

    add_foreign_key :folders, :aggregates, column: :folder_id
    add_foreign_key :folders, :aggregates, column: :folder_id
    add_index :folders, [:folder_id, :content_id], unique: true
  end
end
