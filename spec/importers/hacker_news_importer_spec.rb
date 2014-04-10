require 'spec_helper'

describe HackerNewsImporter do
  subject(:importer) { HackerNewsImporter.new }

  let!(:entry) do
    double("Entry",
            id: 42,
            comments_count: 0,
            time: Time.now)
  end

  let!(:content_response) do
    '''{
      "status": "success",
      "response": {
        "content":
          "example content"
      }
    }'''
  end

  before(:each) do
    entry.stub_chain(:link, :title).and_return "test title"
    entry.stub_chain(:link, :href).and_return "foobar.com"
    entry.stub_chain(:voting, :score).and_return 9
    entry.stub_chain(:user, :name).and_return "mokrzu"

    RubyHackernews::Entry.stub(:all).and_return [entry]

    Boilerpipe.stub(:extract).and_return content_response
  end

  context "update existing article" do
    let!(:article) do
      create(:article,
              source_id: 42)
    end

    before do
      Article.stub_chain(:where, :first_or_initialize).and_return article
    end

    it "updates points" do
      article.should_receive(:points=).with(9)

      importer.import
    end

    it "updates comments count" do
      article.should_receive(:comments_count=).with(0)

      importer.import
    end

    it "don't update title" do
      article.should_not_receive(:title=)

      importer.import
    end

    it "don't update content" do
      article.should_not_receive(:content=)

      importer.import
    end
  end

  context "save new article" do
    let!(:article) do
      create(:article,
              source_id: 42)
    end

    before do
      article.stub(:new_record?).and_return true
      Article.stub_chain(:where, :first_or_initialize).and_return article
    end

    it "updates points" do
      article.should_receive(:points=).with(9)

      importer.import
    end

    it "updates comments count" do
      article.should_receive(:comments_count=).with(0)

      importer.import
    end

    it "don't sets title" do
      article.should_receive(:title=).with("test title")

      importer.import
    end

    it "don't sets content" do
      article.should_receive(:content=).with("example content")

      importer.import
    end
  end
end