class TextFile < ActiveRecord::Base
  mount_uploader :attachment
  validates :name, presence: true

  scope :by_name, -> { order(:name) }
end
