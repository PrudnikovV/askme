class TagsController < ApplicationController
  def show
    @questions = Tag.friendly.find(params[:id]).questions.order(created_at: :desc)
  end
end
