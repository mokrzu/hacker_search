require 'spec_helper'

describe ArticleSearch do
  def search(attributes = {})
    ArticleSearch.new(attributes).search
  end

  def import(*args)
    ArticleIndex.import!(*args)
  end

  context 'query article index' do
    let!(:first_article) { create(:article, title: "developer codes", source_id: 1) }
    let!(:second_article) { create(:article, title: "painter paints", source_id: 2) }
    
    before(:each) do 
      ArticleIndex.purge!
      import article: first_article
      import article: second_article
    end
  
    specify { expect(search(title: "developer").load).to eq([first_article]) }
    specify { expect(search(title: "painter").load).to eq([second_article]) }
    specify { expect(search(source_id: 2).load).to eq([second_article])}
  end
end