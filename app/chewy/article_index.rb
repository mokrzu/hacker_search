class ArticleIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      title: {
        tokenizer: 'keyword',
        filter: ['lowercase']
      },
      content: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  define_type Article do
    field :title, type: 'string'
    field :url
    field :author
    field :points, type: 'integer'
    field :content
    field :comments_count, type: 'integer'
    field :source_id, type: 'integer'
    field :submitted_at, type: 'date'
  end
end