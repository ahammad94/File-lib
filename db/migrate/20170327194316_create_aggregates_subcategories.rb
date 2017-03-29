class CreateAggregatesSubcategories < ActiveRecord::Migration[5.0]
  def change
    create_join_table :aggregates, :subcategories do |t|
      t.index [:aggregate_id, :subcategory_id], name: "index_aggregates_subcategories_on_agg_sub_id"
    end
  end
end
