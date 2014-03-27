class CreateCalendar < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.column :owner, :string

      t.timestamps
    end
  end
end
