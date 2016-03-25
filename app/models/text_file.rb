class TextFile < ActiveRecord::Base
  validates :name, presence: true

  scope :by_name, -> { order(:name) }
  scope :by_date, -> { order(updated_at: :desc) }

  def as_json(options = {})
    hash = super.as_json options
    hash[:attachment] = {url: attachment}
    hash
  end
end
