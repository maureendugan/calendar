require 'bundler/setup'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])

def welcome
  puts "Welcome to the Calendar Manager"
  event_menu
end

def event_menu
  choice = nil

  until choice == 'x'
    puts "Press 'c' to create a new event"
    puts "Press 'l' to list all events"
    puts "Press 'u' to update an event"
    puts "Press 'd' to delete an event"
    puts "Press 'x' to exit"
    choice = prompt('Enter choice').downcase

    case choice
      when 'c' then create_event
      when 'l' then list_events_from_menu
      when 'u' then update_event
      when 'd' then delete_event
      when 'x' then puts "Goodbye!"
      else puts "Please enter a valid option"
    end
  end
end

# EVENT METHODS ====================================================================================

def create_event
  new_description = prompt('Enter event description:')
  new_location = prompt('Enter event location')
  new_start = prompt('Enter start date and time: YYYY-MM-DD hh:mm')
  new_end = prompt('Enter end date and time: YYYY-MM-DD hh:mm')
  new_event = Event.create({  :description => new_description,
                              :location => new_location,
                              :start => new_start,
                              :end => new_end })
  puts "'#{new_event.description}' has been created\n\n"
end

def list_events_from_menu
  puts "Here are all of the events:"
  list_events
  puts "\n\n"
end

def list_events
  Event.all.each { |event| puts "#{event.id}. #{event.description} at #{event.location} starting #{event.display_start} and ending #{event.display_end}"}
end

def update_event
  list_events
  update_id = prompt('Enter the event id of the event to update').to_i
  event_to_update = Event.find(update_id)
  puts "1. Description: #{event_to_update.description}"
  puts "2. Location: #{event_to_update.location}"
  puts "3. Start: #{event_to_update.display_start}"
  puts "4. End: #{event_to_update.display_end}"

  num = prompt('Choose id to update: ').to_i
  new_value = prompt('Enter new value:')
  given_values =  [ event_to_update.description,
                    event_to_update.location,
                    event_to_update.start,
                    event_to_update.end ]
  given_values[num-1] = new_value
  event_to_update.update({  :description => given_values[0],
                            :location => given_values[1],
                            :start => given_values[2],
                            :end => given_values[3] })
  puts "'#{event_to_update.description}' has been updated successfully!\n\n"
end

def delete_event
  list_events
  delete_id = prompt('Enter the event id to delete:').to_i
  event_to_delete = Event.find(delete_id)
  puts "'#{event_to_delete.description}' is being deleted..."
  event_to_delete.destroy
  puts "\t\t\t...success!\n\n"
end

def prompt(question)
  puts question
  gets.chomp
end

system "clear"
welcome
