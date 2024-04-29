require "rails_helper"

RSpec.describe "Foods" do
  describe "GET /api/foods" do
    it "returns all foods" do
      get "/api/foods"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::FoodsController#index")
    end
  end

  describe "GET /api/foods/:id" do
    it "returns food by id" do
      get "/api/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::FoodsController#show")
    end
  end

  describe "POST /api/foods" do
    it "creates a food and returns it" do
      post "/api/foods"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::FoodsController#create")
    end
  end

  describe "PUT /api/foods/:id" do
    it "updates a food and returns it" do
      put "/api/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::FoodsController#update")
    end
  end

  describe "DELETE /api/foods/:id" do
    it "deletes a food and returns it" do
      delete "/api/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::FoodsController#destroy")
    end
  end
end
