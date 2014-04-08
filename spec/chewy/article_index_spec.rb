require 'spec_helper'

describe ArticleIndex do
  context 'article uptdate' do
    let!(:article) { create(:article, source_id: 108) }

    specify do
      expect do
        Article.where(source_id: 108).first.update(points: 300)
      end.to update_index('article#article').and_reindex(article, with: { points: 300 })
    end
  end
end
