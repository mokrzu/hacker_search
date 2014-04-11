require 'spec_helper'

describe ArticleIndex do
  def update_artilce_index(options = {})
    update_index('article#article').and_reindex(article, options)
  end

  context 'article uptdate' do
    let!(:article) { create(:article, source_id: 108) }

    it 'updates index after model update' do
      expect do
        Article.where(source_id: 108).first.update(points: 300)
      end.to update_artilce_index(with: { points: 300 })
    end
  end
end
