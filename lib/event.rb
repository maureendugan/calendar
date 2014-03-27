class Event < ActiveRecord::Base
  belongs_to :calendar

  def display_start
    self.start.strftime("%A %B %d, %Y at %I:%M%p")
  end

  def display_end
    self.end.strftime("%A %B %d, %Y at %I:%M%p")
  end

end
