require 'csv'
FILE = 'contacts.csv'

# puts contacts

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  @@contacts = []
  attr_accessor :name, :email, :id
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, num)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = num
    @@contacts << self
  end

  def to_s
    "#{name}, #{email}, #{id}"
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
       # CSV.open(FILE) do |row|
       #  Contact.new(row[0], row[1])
       # end
       # @@contacts
      i=1
      CSV.foreach(FILE) do |row|
        Contact.new(row[0], row[1], i)
        i+=1
      end
      @@contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      @@contacts = []
      @@contacts = Contact.all

      len = @@contacts.length
      puts "Lenght of contacts array is #{len}"
      CSV.open(FILE, 'ab') do |csv|
        csv << [name, email]
      end
      Contact.new(name,email,len+1)
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      @@contacts.select do |contact|
        if contact.id == id
          return contact
        else
          nil
        end
      end
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
    end

  end

end




