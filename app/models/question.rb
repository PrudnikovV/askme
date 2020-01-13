class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :text, presence: true, length: { maximum: 255 }

  after_create_commit :save_tags

  def text_show
    text.delete("#")
  end

  private

  def find_all_tags
    text.scan(/#[а-яА-ЯёЁa-zA-Z0-9]+/) |
    unless answer.nil?
      answer.scan(/#[а-яА-ЯёЁa-zA-Z0-9]+/)
    else
      []
    end
  end

  def save_tags
    find_all_tags.each do |tag|
      tag.downcase!.delete!("#")
      new_tag = Tag.find_by(name: tag)
      new_tag = Tag.create(name: tag) if new_tag.nil?
      QuestionTag.create(tag: new_tag, question: self) unless QuestionTag.find_by(tag: new_tag, question: self)
    end
  end
end
