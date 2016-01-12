require 'csv'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      contact_array = []
      CSV.foreach("contact_data.csv") do |row|
        contact_array << row
      end
      contact_array
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      id = 1
      CSV.foreach("contact_data.csv") { |line| id += 1}
      contact_list = CSV.open("contact_data.csv", 'a')
      new_contact = [id,name,email]
      contact_list << new_contact
      id
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      CSV.foreach("contact_data.csv") do |line|
        if line[0] == id
          return line
        end
      end
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      contact_array = []
      CSV.foreach("contact_data.csv") do |line|
        if line[1].match(term)
          contact_array << line
        elsif line[2].match(term)
          contact_array << line
        end
      end
      return contact_array
    end

  end

end
