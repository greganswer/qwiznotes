class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.string :title, null: false, limit: 70
      t.text :content, null: false
      t.integer :concepts_count, null: false, default: 0
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
