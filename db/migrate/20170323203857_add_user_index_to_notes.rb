class AddUserIndexToNotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :user, foreign_key: true
    add_column :users, :notes_count, :integer, default: 0, null: false
  end
end
