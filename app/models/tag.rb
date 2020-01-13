class Tag < ApplicationRecord
  has_many :question_tags
  has_many :questions, through: :question_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
end
