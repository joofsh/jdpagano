class ArticlesController < ApplicationController
  before_filter :require_current_user

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update

  end

  def destroy

  end
end
