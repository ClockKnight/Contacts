require 'pg'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email, :id

  def initialize(name, email)
    @name = name
    @email = email
    @id = self.object_id * Random.rand().ceil
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Connect to the postgresql database
    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
      )
    end

    def inDatabase?(new_contact)
      conn = Contact.connection
      conn.exec("SELECT id FROM contacts") do |ids|
        ids.each do |id|
          if id["id"].to_i == new_contact.id
            return true
          end
        end
      end
      false
    end

    def save(new_contact)
      conn = Contact.connection
      if Contact.inDatabase?(new_contact)
        conn.exec("UPDATE contacts SET name = '#{new_contact.name}',
                                       email = '#{new_contact.email}'
                   WHERE id = #{new_contact.id};")
      else
        conn.exec("INSERT INTO contacts (id,name,email)
                   VALUES (#{new_contact.id},
                           '#{new_contact.name}',
                           '#{new_contact.email}');")
      end
    end

    # Returns an Array of Contacts loaded from the database.
    def all
      contact_array = []
      conn = self.connection
      conn.exec('SELECT * FROM contacts;') do |results|
        results.each do |contact|
          new_contact = Contact.new(contact["name"], contact["email"])
          new_contact.id = contact["id"]
          contact_array << new_contact
        end
      end
      contact_array
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      new_contact = Contact.new(name, email)
      Contact.save(new_contact)
      new_contact.id
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      conn = Contact.connection
      new_contact = Contact.new("test","test")
      new_contact.id = id.to_i
      if Contact.inDatabase?(new_contact)
        conn.exec("SELECT * FROM contacts WHERE id = #{id};") do |result|
          result.each do |contact|
            return contact
          end
        end
      else
        nil
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      contact_array = []
      conn = Contact.connection
      conn.exec("SELECT * FROM contacts;") do |result|
        result.each do |contact|
          if contact["name"].match(term)
            contact_array << contact
          elsif contact["email"].match(term)
            contact_array << contact
          end
        end
      end
      contact_array
    end

    def destroy(new_contact)
      conn = Contact.connection
      conn.exec("DELETE FROM contacts WHERE id = #{new_contact.id};")
      puts "Contact deleted."
    end

  end

end
