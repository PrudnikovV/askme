class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new, :destroy]
  before_action :authorize_user, except: [:index, :new, :create, :show, :destroy]

  def load_user
    @user ||= User.find params[:id]
  end

  def index
    @users = User.all
    @tags = Tag.all.order('name')
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
      session[:user_id] = @user.id
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
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    User.destroy(session[:user_id])
    session[:user_id] = nil
    redirect_to root_url, notice: 'Вы успешно удалили аккаунт!'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                  :name, :username, :avarat_url, :background_color)
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end
