class CreateAggregatesSelfJoin < ActiveRecord::Migration[5.0]
  def change

    create_table :folder_contents do |t|
      t.references :aggregate, index: true, foreign_key: true
      t.references :content, index: true

      t.timestamps null: false
    end

    add_foreign_key :folder_contents, :aggregates, column: :content_id
    add_index :folder_contents, [:aggregate_id, :content_id], unique: true

  end
end
