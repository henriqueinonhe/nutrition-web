# frozen_string_literal: true

require "rails_helper"

RSpec.describe "MealEntries" do
  describe "GET /meal_entries" do
    it "returns all meal entries" do
      get "/meal_entries"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body[:handler]).to eq("MealEntriesController#index")
    end
  end

  describe "POST /meal_entries" do
    it "creates a meal entry and returns it" do
      post "/meal_entries"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("MealEntriesController#create")
    end
  end

  describe "PUT /meal_entries/:id" do
    it "updates a meal entry and returns it" do
      put "/meal_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("MealEntriesController#update")
    end
  end

  describe "DELETE /meal_entries/:id" do
    it "deletes a meal entry and returns it" do
      delete "/meal_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("MealEntriesController#destroy")
    end
  end
end
