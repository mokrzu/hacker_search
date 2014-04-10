require 'spec_helper'

describe ArticleController do
  describe "GET #index" do
    let!(:matching_article) {
      create(:article, title: "tesla cars", source_id: 11)
    }

    let!(:other_article) {
      create(:article, title: "wrong article", source_id: 22)
    }

    it "responds successfully with an HTTP 200 status code" do
      get :index

      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index

      expect(response).to render_template("index")
    end

    it "loads matching entries to @articles" do

      get :index, { search: {"query"=>"tesla"} }

      expect(assigns(:articles)).to match_array([matching_article])
    end
  end
end