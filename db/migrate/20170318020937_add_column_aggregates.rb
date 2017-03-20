class AddColumnAggregates < ActiveRecord::Migration[5.0]
  def change
    add_column :aggregates, :file_type , :string
  end
end
