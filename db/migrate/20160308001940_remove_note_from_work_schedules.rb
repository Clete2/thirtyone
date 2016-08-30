class RemoveNoteFromWorkSchedules < ActiveRecord::Migration
  def change
    remove_column :work_schedules, :note, :string
  end
end
