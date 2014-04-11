require 'spec_helper'

describe Article do
  context 'when valid' do

    let!(:article) { build(:article) }

    specify { expect(article).to be_valid }

    it 'should update index on save' do
      expect { article.save }.to update_index('article#article')
    end
  end

  context 'when title not valid' do
    let!(:invalid_article) { build(:article, title: "") }

    specify { expect(invalid_article).not_to be_valid }
  end

  context 'when content not valid' do
    let!(:invalid_article) { build(:article, content: "") }

    specify { expect(invalid_article).not_to be_valid }
  end

  context 'when source_id not valid' do
    context 'source_id not present' do
      let!(:invalid_article) { build(:article, source_id: nil) }

      specify { expect(invalid_article).not_to be_valid }
    end

    context 'source_id not uniqe' do
      let!(:first_article) { create(:article) }
      let!(:second_article) { build(:article) }

      specify { expect(second_article).not_to be_valid }
    end
  end
end
