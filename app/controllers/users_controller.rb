class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def load_user
    @user ||= User.find params[:id]
  end

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                  :name, :username, :avarat_url)
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end
