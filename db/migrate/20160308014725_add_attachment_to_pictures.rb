class AddAttachmentToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :attachment, :string
  end
end
