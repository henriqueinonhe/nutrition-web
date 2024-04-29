require "rails_helper"

RSpec.describe "Meal Entries" do
  describe "GET /api/meal_entries" do
    it "returns all meal entries" do
      get "/api/meal_entries"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::MealEntriesController#index")
    end
  end

  describe "GET /api/meal_entries/:id" do
    it "returns meal entry by id" do
      get "/api/meal_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::MealEntriesController#show")
    end
  end

  describe "POST /api/meal_entries" do
    it "creates a meal entry and returns it" do
      post "/api/meal_entries"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::MealEntriesController#create")
    end
  end

  describe "PUT /api/meal_entries/:id" do
    it "updates a meal entry and returns it" do
      put "/api/meal_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::MealEntriesController#update")
    end
  end

  describe "DELETE /api/meal_entries/:id" do
    it "deletes a meal entry and returns it" do
      delete "/api/meal_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::MealEntriesController#destroy")
    end
  end
end
