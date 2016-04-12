require 'pg'
require 'pry'
require_relative './contact'
require 'colorize'
puts "Welcome to the Contact List App"

conn = PG::Connection.new(dbname: 'contacts', host: 'localhost', user: 'development', password: 'development')
Contact.set_connection(conn)

puts "***************************************"
puts " Select a command: "
puts "    list    (show all contacts)"
puts "    new     (create a new contact)"
puts "    find    (find a contact by ID#)"
puts "    search  (search by name or email)"
puts "***************************************"

command = gets.chomp

case command

when "list"
  puts "LIST"
  contacts = Contact.all
  contacts.each do |contact|
    puts "ID# #{contact.id} Name: #{contact.name} Email: #{contact.email}"
  end

when "new"
  puts "Enter the contact name: "
  name = gets.chomp
  puts "Enter the contact email: "
  email = gets.chomp
  Contact.create(name: name, email: email)
  puts "New contact created! (Name: #{name}, Email: #{email})"

when "find"
  puts "Enter the ID# of the contact you want to find: "
  id = gets.chomp.to_i
  result = Contact.find(id)[0]
  puts "Result of find = ID#: #{result['id']} Name: #{result['name']} Email: #{result['email']}"

when "search"
  puts "Enter the name or email you want to search for: "
  term = gets.chomp
  contacts = Contact.search(term)
  contacts.each do |contact|
    puts "ID# #{contact.id} Name: #{contact.name} Email: #{contact.email}"
  end

else
  puts "Invalid command, program exiting"

end
