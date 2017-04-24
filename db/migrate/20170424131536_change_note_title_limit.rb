class ChangeNoteTitleLimit < ActiveRecord::Migration[5.0]
  def up
    change_column :notes, :title, :string, limit: nil
  end

  def down
    change_column :notes, :title, :string, limit: 70
  end
end
