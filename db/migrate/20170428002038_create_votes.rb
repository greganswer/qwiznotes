class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :item, null: false, index: true, polymorphic: true
      t.datetime   :deleted_at
      t.timestamps null: false
    end
    add_column :notes, :votes_count, :integer, default: 0
    add_column :users, :votes_count, :integer, default: 0
  end
end
