require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  command = ARGV[0]
  parameter = ARGV[1]
  case command
  when "new"
    print "Enter the contacts full name: "
    name = $stdin.gets.chomp
    print "Enter the contacts email address: "
    email = $stdin.gets.chomp
    id = Contact.create(name, email)
    puts "Contact created with id: #{id}"
  when "list"
      puts "Connecting to the database..."
      contact_list = Contact.all
      num_records = 0
      contact_list.each do |contact|
        num_records += 1
        puts "#{contact.id} #{contact.name}  (#{contact.email})"
      end
      puts "-------------------------------------------------------------------"
      puts "#{num_records} records total"
  when "show"
    puts "Connecting to the database..."
    contact = Contact.find(parameter)
    if contact == nil
      puts "That id is not in the database."
    else
      puts "#{contact["id"]}: #{contact["name"]}  (#{contact["email"]})"
    end
  when "search"
    puts "Connecting to the database..."
    contact_list = Contact.search(parameter)
    num_records = 0
    contact_list.each do |contact|
      num_records += 1
      puts "#{contact["id"]}: #{contact["name"]}  (#{contact["email"]})"
    end
    puts "-------------------------------------------------------------------"
    puts "#{num_records} records total"
  when "update"
    puts "Connecting to the database..."
    contact = Contact.find(parameter)
    if contact == nil
      puts "That id is not in the database."
    else
      puts "Enter new data to update the entry with:"
      puts "An empty entry will use current entrys values."
      print "Enter a new name: "
      name = $stdin.gets.chomp
      if name == ""
        name = contact["name"]
      end
      print "Enter a new email: "
      email = $stdin.gets.chomp
      if email == ""
        email = contact["email"]
      end
      new_contact = Contact.new(name,email)
      new_contact.id = contact["id"].to_i
      Contact.save(new_contact)
    end
  when "delete"
    puts "Connecting to the database..."
    new_contact = Contact.new("test","test")
    new_contact.id = parameter.to_i
    if Contact.inDatabase?(new_contact)
      Contact.destroy(new_contact)
    else
      puts "A contact with that id is not in the database."
    end
  else
    puts "Here is a list of available commands:"
    puts "           new - Create a new contact"
    puts "          list - List all contacts"
    puts "     show (id) - Show a contact"
    puts " search (term) - Search contacts"
    puts "   update (id) - Update a contact"
    puts "   delete (id) - Delete a contact"
  end
end
