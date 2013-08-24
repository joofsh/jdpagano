class ArticlesController < ApplicationController
  before_filter :require_current_user

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = 'Article Created!'
      redirect_to articles_path
    else
      flash[:notice] = 'Failed to save article'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(article_params)
      flash[:notice] = 'Article Updated!'
      redirect_to root_path
    else
      flash[:notice] = 'Failed to update article'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = 'Article Destroyed!'
    else
      flash[:notice] = 'Failed to destroy article'
    end
    redirect_to articles_path
  end

private
  def article_params
    params.require(:article).permit(:title, :body, :image)
  end
end
