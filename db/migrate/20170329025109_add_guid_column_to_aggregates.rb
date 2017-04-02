class AddGuidColumnToAggregates < ActiveRecord::Migration[5.0]
  def change
    add_column :aggregates, :guid, :integer
  end
end
