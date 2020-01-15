class Question < ApplicationRecord
  REGULAR_TAG = /#[[:word:]]+/
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags, dependent: :destroy

  validates :text, presence: true, length: { maximum: 255 }

  after_save_commit :save_tags
  after_destroy_commit :destroy_tags

  def text_show
    text.delete("#")
  end

  def answer_show
    answer.delete("#")
  end

  private

  def find_all_tags
    "#{text} #{answer}".scan(REGULAR_TAG)
  end

  def save_tags
    find_all_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag.downcase.delete("#"))
      QuestionTag.find_or_create_by(tag: new_tag, question: self)
    end
  end

  def destroy_tags
    Tag.left_outer_joins(:questions).where(questions: {id: nil}).destroy_all
  end
end
