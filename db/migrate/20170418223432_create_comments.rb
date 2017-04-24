class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :item, null: false, index: true, polymorphic: true
      t.text :content, null: false
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
