class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/' \
          '71269686e0f757ddb4f73614f43ae445?s=100'
      ),
      User.new(id: 2, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'installero',
      avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
      Question.new(
        text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016')
      )
    ]
    @new_question = Question.new
    @count_questions = "Всего задано #{@questions.count} #{inclination(@questions.count,'вопрос','вопроса','вопросов')}"
  end

  def inclination(quantity, word, word2, word3)
    quantity = quantity % 100
    rest = quantity % 10
      if rest == 0 || rest >= 5 || (10..20).include?(quantity)
        return word3
      elsif rest >= 2
        return word2
      end
    return word
  end
end
