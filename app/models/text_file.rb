class TextFile < ActiveRecord::Base
  mount_uploader :attachment, TextFileAttachmentUploader
  validates :name, presence: true

  scope :by_name, -> { order(:name) }
  scope :by_date, -> { order(updated_at: :desc) }
end
