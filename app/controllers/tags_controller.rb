class TagsController < ApplicationController
  def show
    @questions = Tag.find(params[:id]).questions.order(created_at: :desc)
  end
end
