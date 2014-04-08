class ArticleSearch
  include ActiveData::Model

  attribute :query, type: String
  attribute :title, type: String
  attribute :source_id, type: Integer

  def index
      ArticleIndex
  end

  def search
    [query_string, title_filter, source_id_filter].compact.reduce(:merge)
  end

  def query_string
    index.query(query_string: { fields: [:title, :content],
                                query: query, default_operator: 'and'}) if query?
  end

  def title_filter
    index.filter(term: {title: title}) if title?
  end

  def source_id_filter
    index.filter(term: {source_id: source_id}) if source_id?
  end
end
