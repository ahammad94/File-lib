class RenameAggregatesColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :aggregates, :file_type, :file
  end
end
