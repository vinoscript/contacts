require 'active_record'
require_relative 'contact2'

ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts "Welcome to the Contact List App"

input = ARGV

if input == []
  puts "***************************************"
  puts " Select a command: "
  puts "    list    (show all contacts)"
  puts "    new     (create a new contact)"
  puts "    find    (find a contact by ID#)"
  puts "    search  (search by name or email)"
  puts "    update  (update contact)"
  puts "    delete  (delete contact)"
  puts "***************************************"
  command = gets.chomp
  option = nil
else
  command = input[0]
  option = input[1]
end

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
  result = Contact.find(id)
  puts "Result of find = #{result}"

when "search"
  puts "Enter the name or email you want to search for: "
  term = gets.chomp
  contacts = Contact.search(term)
  contacts.each do |contact|
    puts "ID# #{contact.id} Name: #{contact.name} Email: #{contact.email}"
  end

when "update"
  puts "Enter the ID# of the contact to update: "
  id = gets.chomp.to_i
  result = Contact.find(id)
  puts "Contact to be updated = #{result}"
  puts "Enter the new name: "
  new_name = gets.chomp
  puts "Enter the new email: "
  new_email = gets.chomp
  the_contact = result
  the_contact.name = new_name
  the_contact.email = new_email
  the_contact.save
  puts "Contact was updated"

when "delete"
  puts "Enter the ID# of the contact to delete: "
  id = gets.chomp.to_i
  result = Contact.find(id)
  result.destroy
  puts "The following contact was deleted: #{result}"

else
  puts "Invalid command, program exiting"

end

