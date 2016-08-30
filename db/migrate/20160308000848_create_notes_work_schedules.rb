class CreateNotesWorkSchedules < ActiveRecord::Migration
  def change
    create_table :notes_work_schedules do |t|
      t.integer :note_id
      t.integer :work_schedule_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
