# (c) goodprogrammer.ru

# Модель вопроса.
#
# Каждый экземпляр этого класса — загруженная из БД информация о конкретном
# вопросе.
class Question < ActiveRecord::Base
  # Эта команда добавляет связь с моделью User на уровне объектов она же
  # добавляет метод .user к данному объекту.
  #
  # Вспоминайте уроки про рельционные БД и связи между таблицами.
  #
  # Когда мы вызываем метод user у экземпляра класса Question, рельсы
  # поймут это как просьбу найти в базе объект класса User со значением id
  # равный question.user_id.
  belongs_to :user

  # Эта валидация препятствует созданию вопросов, у которых нет пользователя
  # если задан пустой текст вопроса (поле text пустое), объект не будет сохранен
  # в базу.
  validates :user, :text, presence: true

  # Ошибки валидаций можно посмотреть методом errors.

  # Демонтрация жизненного цикла объекта навесили на все популярные коллбэки
  # вои методы.
  before_validation :before_validation
  after_validation :after_validation

  before_save :before_save
  after_save :after_save

  before_create :before_create
  after_create :after_create

  before_update :before_update
  after_update :after_update

  before_destroy :before_destroy
  after_destroy :after_destroy

  private

  # Динамически сгенерируем пару методов для каждого действия, используя
  # возможности руби (этот код нужен только для демонстрации валидаций и потом
  # мы его удалим).
  %w(validation save create update destroy).each do |action|
    %w(before after).each do |time|
      define_method("#{time}_#{action}") do
        puts "******> #{time} #{action}"
      end
    end
  end
end
