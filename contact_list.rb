require_relative 'contact'
# require 'csv'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def initialize

  end

  def display_menu
    puts "Here is a list of available commands: "
    puts "\t new    - Create a new contact"
    puts "\t list   - List all contacts"
    puts "\t show   - Show a contact"
    puts "\t search - Search contacts"
  end

  # def display_new(input)
  #   puts "You choose new"
  #   puts Contact.create(input[1], input[2])
  # end

  def get_user_input(input) 
    # case statement
    # puts Contact.all
    choice = input[0]
    case choice
    when 'new'
      puts "you choose new"
      puts Contact.create(input[1], input[2])
    when 'list'
      puts "you choose list"
      puts contact_array = Contact.all
      puts "Total contacts: #{contact_array.length}"
    when 'show'
      puts "you choose show by ID"
      # Contact.all
      puts Contact.find(input[1].to_i)
    when 'search'
      puts "you choose search"
      # Contact.all
      p Contact.search(input[1].downcase)
    else 
      display_menu
      # choice = gets.chomp
      # get_user_input(choice)
    end
  end

end

# input = ARGV 
# if input.empty?
#   ContactList.display_menu
# case input

# mycontacts = ContactList.new
# mycontacts.display_menu

# # ContactList.display_menu
contact_list = ContactList.new
# contact_list.get_user_input
# puts Contact.all

input = ARGV
contact_list.get_user_input(input)

# puts Contact.create('Willemina', 'wstikk@gmail.com')


# p Contact.find(3)
# p Contact.search('illemi')
