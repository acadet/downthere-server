class AddAttachmentToTextFiles < ActiveRecord::Migration
  def change
    add_column :text_files, :attachment, :string
  end
end
