class TagsController < ApplicationController
  def show
    @questions = Tag.find_by(name: params[:id]).questions.order(created_at: :desc)
  end
end
