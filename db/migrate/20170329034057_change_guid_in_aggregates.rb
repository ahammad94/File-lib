class ChangeGuidInAggregates < ActiveRecord::Migration[5.0]
  def change
  	change_column :aggregates, :guid, :string
  end
end
