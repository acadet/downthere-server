class CreateTextFiles < ActiveRecord::Migration
  def change
    create_table :text_files do |t|
      t.string :name
      t.string :attachment

      t.timestamps null: false
    end
  end
end
