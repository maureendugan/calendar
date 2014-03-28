class Event < ActiveRecord::Base
  belongs_to :calendar
  validates :description, presence: true
  validates :location, presence: true
  validates_datetime :start
  validates_datetime :end

  def display_start
    self.start.strftime("%A %B %d, %Y at %I:%M%p")
  end

  def display_end
    self.end.strftime("%A %B %d, %Y at %I:%M%p")
  end

end
