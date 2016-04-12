
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
    

    def find(id)
      result = @@conn.exec_params("SELECT * FROM contacts WHERE id = $1::int", [id])
      result.to_a
    end
    

    def search(term)
      result = @@conn.exec_params("SELECT DISTINCT * FROM contacts WHERE name LIKE $1 OR email LIKE $1", ["%"+term+"%"])
      contacts = []
      result.each_row do |row|
        id = row[0]
        name = row[1]
        email = row[2]
        contacts << Contact.new(id, name, email)
      end
      contacts
    end

  end

end




