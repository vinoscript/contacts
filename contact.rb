
class Contact

  attr_accessor :name, :email
  attr_reader :id

  
  def initialize(id, name, email)
    @id = id
    @name = name
    @email = email
  end

  def delete
    @@conn.exec("DELETE from contacts where id=#{@id};")
  end

  #if contact is in db already, update. Else, insert. 
  def save 
    if @id 
      @@conn.exec_params("UPDATE contacts SET name = $1, email = $2 WHERE id = $3::int;", [@name, @email, @id])
    else 
      result = @@conn.exec_params("INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id;", [@name, @email])
      @id = result[0]['id'].to_i
    end
  end

  def to_s
    "#{id} #{name} #{email}"
  end

  class << self

    def set_connection(conn)
      @@conn = conn
    end

    def hash_to_contact(some_hash)
      Contact.new(some_hash['id'].to_i, some_hash['name'], some_hash['email'])
    end

    def all
      result = @@conn.exec("SELECT * FROM contacts ORDER BY id;")
      contacts = []
      result.each do |row|
        contacts << hash_to_contact(row)
      end
      contacts
    end
   
    def create(attributes)
      new_contact = Contact.new(nil, attributes[:name], attributes[:email])
      new_contact.save
    end
    

    def find(id)
      result = @@conn.exec_params("SELECT * FROM contacts WHERE id = $1::int;", [id])
      if result.ntuples > 0
        hash_to_contact(result[0])
      end
    end
    

    def search(term)
      p result = @@conn.exec_params("SELECT DISTINCT * FROM contacts WHERE name LIKE $1 OR email LIKE $1;", ["%"+term+"%"])
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




