class Addcolumnaggregates < ActiveRecord::Migration[5.0]
  def change
    drop_table :folders
    create_table :folders do |t|
      t.integer :folder_id
      t.integer :content_id
    end

    add_foreign_key :folders, :aggregates, column: :folder_id
    add_foreign_key :folders, :aggregates, column: :content_id
    add_index :folders, [:folder_id, :content_id], unique: true
  end
end
