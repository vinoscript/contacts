require 'csv'
FILE = 'contacts.csv'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  # @@contacts = []
  attr_accessor :name, :email, :id
  
  def initialize(name, email, num)
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
      CSV.read(FILE).each_with_index.map do |row, i|
        Contact.new(row[0], row[1], i+1)
      end
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      CSV.open(FILE, 'a') << [name, email]
      Contact.new(name,email,Contact.all.length + 1)
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      Contact.all.select do |contact|
        contact.id == id
      end
    end
    
    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      Contact.all.select do |contact|
        contact.name.downcase.match(term) || contact.email.downcase.match(term)
      end
    end

  end

end




