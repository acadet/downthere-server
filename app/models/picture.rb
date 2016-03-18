class Picture < ActiveRecord::Base
  mount_uploader :attachment, PictureAttachmentUploader

  scope :by_name, -> { order(:name) }
  scope :by_date, -> { order(updated_at: :desc) }
end
