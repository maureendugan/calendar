require 'bundler/setup'
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

I18n.enforce_available_locales = false

RSpec.configure do |config|
  config.after(:each) do
    Calendar.all.each { |calendar| calendar.destroy }
    Event.all.each { |event| event.destroy }
  end
end
