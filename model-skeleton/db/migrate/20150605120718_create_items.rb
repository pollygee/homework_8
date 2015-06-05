class CreateItems < ActiveRecord::Migration
  def change
    create_table "items" do |t|
      t.string "do"
      t.datetime "created_at"
      t.integer "list_id"
      t.datetime "due_date"
      t.boolean "done?"
    end
  end
end
