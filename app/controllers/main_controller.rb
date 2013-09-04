class MainController < ApplicationController
  def index
    if current_admin
      @articles = Article.all
    else
      @articles = Article.where(published: true)
    end
  end

  def missing
    redirect_to root_path
  end
end
