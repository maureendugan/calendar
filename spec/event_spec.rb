require 'spec_helper'

describe Event do
  it 'should have one event belong to a calendar' do
    test_calendar = Calendar.create({:owner => 'Maureen'})
    test_event = Event.create({:description => 'wash the car',
                  :location => 'Moes House', :start => '2014-03-27 01:13',
                  :end => '2014-03-27 19:30:00'})
    test_calendar.events << test_event
    test_event.calendar.owner.should eq 'Maureen'
  end
  it { should belong_to :calendar }
  describe '#display_start' do
    it 'should reformat the start date and time for a person to read' do
      test_event = Event.create({ :description => 'run',
                                  :location => 'outside',
                                  :start => "2014-03-29 11:30",
                                  :end => "2014-03-29 13:30"})
      test_event.display_start.should eq 'Saturday March 29, 2014 at 11:30AM'
    end
  end
  describe '#display_end' do
    it 'should reformat the end date and time for a person to read' do
      test_event = Event.create({ :description => 'run',
                                  :location => 'outside',
                                  :start => "2014-03-29 11:30",
                                  :end => "2014-03-29 13:30"})
      test_event.display_end.should eq 'Saturday March 29, 2014 at 01:30PM'
    end
  end
end
