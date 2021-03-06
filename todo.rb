require 'pry'
require './db/setup'
require './lib/all'
require 'date'

puts "Welcome to Todo"
class ToDo
  def add_item new_list_name, new_todo_item
    list = List.where(list_name: new_list_name).first_or_create!
    item = Item.where(list_id: list.id, todo: new_todo_item).first_or_create!
    puts "Your task #{new_todo_item} was added to #{new_list_name}"
  end

  def add_due_date item, date
    date = Date.parse date
    if p = Item.where(todo: item).first
      p.due_date = date
      p.save
      puts "Your due date #{date} was added to #{item}"
    end
  end

  def add_done item
    p = Item.where(todo: item).first
    p.done = true
    p.save
    puts "Your task #{item} was marked as done"
  end

  def list *option
    if option[0] == 'all'
      q = Item.where(done: true).pluck(:todo)
      q.each do |t|
        p << "#{t} (done)"
      end
    elsif !option[0].nil?
      p = Item.where(name: option.first)
      p = Item.where(done: nil).pluck(:todo)
    else
      p = Item.where(done: nil).pluck(:todo)
    end
    return p.join(", ")
  end

  def next
    p = Item.where(done: nil)
    if  Item.where("due_date IS NOT NULL")
      p.where("due_date IS NOT NULL").pluck(:todo).sample
    else
      p.pluck(:todo).sample
    end
  end

  def search term
    p = Item.where("todo LIKE ?", "%#{term}%").pluck(:todo)
    if p
      puts "Items with #{term} in it are: #{p.join(", ")}"
    end
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
    option = ARGV.first
    list = todo.list option
  else
    list = todo.list
  end
elsif command == 'next'
  list = todo.next
elsif command == 'search'
  todo.search ARGV.shift
else
  puts "Commands options are \nadd [list_name] [todo_item]\ndue [item] [time - year, month, day]\ndone [item]
  list [*list_name][*all (gives all items including done)]\nnext, search ['string to match']"
end
if list
  puts "Things to do: #{list}"
end
