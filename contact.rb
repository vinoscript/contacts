
class Contact

  attr_reader :name, :email, :id
  
  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email
  end

  def delete
    @@conn.exec("DELETE from contacts where id=#{@id}")
  end

  def save
  @@conn.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2)", [@name, @email])
  end

  class << self

    def set_connection(conn)
      @@conn = conn
    end

    def all
      result = @@conn.exec("SELECT * FROM contacts")
      contacts = []
      result.each_row do |row|
        id = row[0]
        name = row[1]
        email = row[2]
        contacts << Contact.new(id, name, email)
      end
      contacts
    end
   
    def create(attributes)
      new_contact = Contact.new(nil, attributes[:name], attributes[:email])
      new_contact.save
    end
    

    # def find(id)
    #   Contact.all.select do |contact|
    #     contact.id == id
    #   end
    # end
    

    # def search(term)
    #   # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
    #   Contact.all.select do |contact|
    #     contact.name.downcase.match(term) || contact.email.downcase.match(term)
    #   end
    # end

  end

end




