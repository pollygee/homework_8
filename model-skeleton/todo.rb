require 'pry'
require './db/setup'
require './lib/all'
require 'date'

puts "Welcome to Todo"
puts "Command options \nadd [list_name] [todo_item]"
class ToDo
  def add_item new_list_name, new_todo_item
    list = List.where(list_name: new_list_name).first_or_create!
    item = Item.where(list_id: list.id, todo: new_todo_item).first_or_create!
  end

  def add_due_date item, date
    date = Date.parse date
    p = Item.where(todo: item).first
    p.due_date = date
  end

end

todo  = ToDo.new
command = ARGV.shift

if command == "add"
  list_name, todo_item = ARGV
  todo.add_item list_name, todo_item
elsif command == 'due'
  item, date = ARGV
  todo.add_due_date item, date
else
  puts "Command I know are \n add [list_name] [todo_item]"
end