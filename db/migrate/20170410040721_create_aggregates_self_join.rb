class CreateAggregatesSelfJoin < ActiveRecord::Migration[5.0]
  def change

    create_table :folder_contents do |t|
      t.integer :folder_id
      t.integer :content_id
      t.timestamps null: false
    end

    add_foreign_key :folder_contents, :aggregates, column: :folder_id
    add_foreign_key :folder_contents, :aggregates, column: :folder_id
    add_index :folder_contents, [:aggregate_id, :content_id], unique: true

  end
end
