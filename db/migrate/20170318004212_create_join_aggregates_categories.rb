class CreateJoinAggregatesCategories < ActiveRecord::Migration[5.0]
  def change
    create_join_table :aggregates, :categories do |t|
      t.index [:aggregate_id, :category_id]
    end
  end
end
