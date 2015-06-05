class ChangedDoColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :do, :todo
  end
end