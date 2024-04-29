# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Foods" do
  describe "GET /foods" do
    it "returns all foods" do
      get "/foods"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body[:handler]).to eq("FoodsController#index")
    end
  end

  describe "GET /foods/:id" do
    it "returns a food" do
      get "/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("FoodsController#show")
    end
  end

  describe "GET /foods/new" do
    it "returns a form to create a new food" do
      get "/foods/new"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("FoodsController#new")
    end
  end

  describe "POST /foods" do
    it "creates a food and returns it" do
      post "/foods"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("FoodsController#create")
    end
  end

  describe "PUT /foods/:id" do
    it "updates a food and returns it" do
      put "/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("FoodsController#update")
    end
  end

  describe "DELETE /foods/:id" do
    it "deletes a food and returns it" do
      delete "/foods/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("FoodsController#destroy")
    end
  end
end
