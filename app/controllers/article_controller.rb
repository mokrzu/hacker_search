class ArticleController < ApplicationController
  def index
    @search = ArticleSearch.new(params[:search])

    if !params[:search].nil? && !params[:search].empty?
      @articles = @search.search.only(:id).load(
        article: { scope: Article }
      ).sort_by { |article| -article.points } 
    end
  end
end
