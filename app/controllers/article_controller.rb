class ArticleController < ApplicationController
  def index
    @search = ArticleSearch.new(params[:search])

    unless params[:search].blank?
      @articles = @search.search.only(:id).load(
        article: { scope: Article }
      ).compact.sort_by { |article| -article.points }
    end

  rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
    @articles = []
    @error = e.message
  end
end
