class Picture < ActiveRecord::Base
  mount_uploader :attachment, PictureAttachmentUploader
  validates :name, presence: true

  scope :by_name, -> { order(:name) }
end
