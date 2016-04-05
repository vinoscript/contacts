require 'csv'
FILE = 'contacts.csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  # @@contacts = []
  attr_accessor :name, :email, :id
  
  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email, num)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
    @id = num
    # @@contacts << self
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
      i=1
      contacts = []
      CSV.foreach(FILE) do |row|
        # Contact.new(row[0], row[1], row[2])
        contacts << Contact.new(row[0], row[1], i)
        i+=1
      end
      contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      # @@contacts = []
      # @@contacts = Contact.all

      len = @@contacts.length
      puts "Length of contacts array is #{len}"
      CSV.open(FILE, 'ab') do |csv|
        # new_id = CSV.read(FILE).last[2].to_i + 1
        csv << [name, email]
      end
      Contact.new(name,email,len+1)
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      # @@contacts = []
      # @@contacts = Contact.all

      Contact.all.select do |contact|
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
      # @@contacts = []
      # @@contacts = Contact.all

      # Contact.all.select do |contact|
      Contact.all.select do |contact|
        if contact.name.downcase.match(term) || contact.email.downcase.match(term)
          contact
        else
          nil
        end
      end
    end

  end

end




