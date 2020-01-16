class Tag < ApplicationRecord
  extend FriendlyId
  has_many :question_tags
  has_many :questions, through: :question_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }

  friendly_id :name, use: :slugged

  def normalize_friendly_id(text)
    text.to_s
  end

end
