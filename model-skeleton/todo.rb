require 'pry'
require './db/setup'
require './lib/all'
require 'date'

puts "Welcome to Todo"
class ToDo
  def add_item new_list_name, new_todo_item
    list = List.where(list_name: new_list_name).first_or_create!
    item = Item.where(list_id: list.id, todo: new_todo_item).first_or_create!
  end

  def add_due_date item, date
    date = Date.parse date
    p = Item.where(todo: item).first
    p.due_date = date
    p.save
  end

  def add_done item
    p = Item.where(todo: item).first
    p.done = true
    p.save
  end

  def list *option
    if option == 'all'
      p = Items.all #need to somehow mark done items as done
    elsif option
      binding.pry
      p = Item.where(name: option.first, done: true).pluck(:todo)
    else
      p = Item.where(done: true).pluck(:todo)
    end
    p.save
    return p.join
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
elsif command == 'done'
  item = ARGV.first
  todo.add_done item
elsif command == 'list'
  if ARGV 
    option = ARGV
  end
  if option 
    list = todo.list option
  else
    list = todo.list
    puts "All of your todo's are: #{list}"
  end
else
  puts "Commands I know are \n add [list_name] [todo_item]\n
            due [item] [time - year, month, day]\n
            done [item]\n"
end



