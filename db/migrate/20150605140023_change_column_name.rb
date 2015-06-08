class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :items, :done?, :done
  end
end
