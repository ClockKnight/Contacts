require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  command = ARGV[0]
  parameter = ARGV[1]
  case command
  when nil
      puts "Here is a list of available commands:"
      puts "  new    - Create a new contact"
      puts "  list   - List all contacts"
      puts "  show   - Show a contact"
      puts "  search - Search contacts"
  when "new"
    print "Enter the contacts full name: "
    name = $stdin.gets.chomp
    print "Enter the contacts email address: "
    email = $stdin.gets.chomp
    id = Contact.create(name, email)
    puts "Contact created with id: #{id}"
  when "list"
      contact_list = Contact.all
      num_records = 0
      contact_list.each do |contact|
        num_records += 1
        puts "#{contact[0]}: #{contact[1]}  (#{contact[2]})"
      end
      puts "-------------------------------------------------------------------"
      puts "#{num_records} records total"
  when "show"
    contact = Contact.find(parameter)
    puts "#{contact[0]}: #{contact[1]}  (#{contact[2]})"
  when "search"
    contact_list = Contact.search(parameter)
    num_records = 0
    contact_list.each do |contact|
      num_records += 1
      puts "#{contact[0]}: #{contact[1]}  (#{contact[2]})"
    end
    puts "-------------------------------------------------------------------"
    puts "#{num_records} records total"
  end
end
