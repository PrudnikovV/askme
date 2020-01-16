class TagsController < ApplicationController
  def show
    if Tag.friendly.exists?(params[:id])
      @questions = Tag.friendly.find(params[:id]).questions.order(created_at: :desc)
    else
      render file: 'public/404', status: :not_found, :formats => [:html]
    end
  end
end
