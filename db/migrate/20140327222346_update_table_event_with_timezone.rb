class UpdateTableEventWithTimezone < ActiveRecord::Migration
  def change
    remove_column :events, :start
    remove_column :events, :end
    add_column :events, :start, :timestamptz
    add_column :events, :end, :timestamptz
  end
end
