class MainController < ApplicationController
  def index
    @articles = @blog.articles.desc(:created_at)

    # Filter out un-published articles unless admin
    @articles = @articles.where(published: true) unless current_admin
  end

  def missing
    redirect_to root_path
  end
end
