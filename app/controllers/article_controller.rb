class ArticleController < ApplicationController
  def index
    @search = ArticleSearch.new(params[:search])

    unless params[:search].blank?
      @articles = @search.search.only(:id).load(
        article: { scope: Article }
      ).sort_by { |article| -article.points }
    end
  end
end
