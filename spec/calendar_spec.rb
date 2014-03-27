require 'spec_helper'

describe Calendar do
  it 'has one event' do
    test_calendar = Calendar.create({:owner => 'Patti' })
    test_event = Event.create({:description => 'Birthday Party',
                  :location => 'Park', :start => '2014-01-01 12:30:00',
                  :end => '2014-01-02 12:30:00', :calendar_id => test_calendar.id})
    test_calendar.events.should eq [test_event]
  end
  it 'has many events' do
    test_calendar = Calendar.create({:owner => 'Patti' })
    test_event1 = Event.create({:description => 'Birthday Party',
                  :location => 'Park', :start => '2014-01-01 12:30:00',
                  :end => '2014-01-02 12:30:00'})
    test_event2 = Event.create({:description => 'hit the gym',
                  :location => '24 hr fitness', :start => '2014-03-05 12:30:00',
                  :end => '2014-03-05 01:30:00'})
    test_calendar.events << test_event1
    test_calendar.events << test_event2
    test_calendar.events.should eq [test_event1, test_event2]
  end
  it { should have_many :events }
end
