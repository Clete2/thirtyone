class CreateNotesHouseholds < ActiveRecord::Migration
  def change
    create_table :notes_households do |t|
      t.integer :note_id
      t.integer :household_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
