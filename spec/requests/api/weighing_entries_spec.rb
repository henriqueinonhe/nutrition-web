require "rails_helper"

RSpec.describe "WeighingEntries" do
  # describe "GET /api/weighing_entries" do
  #   it "returns all weighing entries" do
  #     get "/api/weighing_entries"

  #     expect(response).to have_http_status(:ok)
  #     expect(response.body).to eq("Api::WeighingEntriesController#index")
  #   end
  # end

  describe "GET /api/weighing_entries/:id" do
    it "returns weighing entry by id" do
      get "/api/weighing_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::WeighingEntriesController#show")
    end
  end

  describe "POST /api/weighing_entries" do
    it "creates a weighing entry and returns it" do
      post "/api/weighing_entries"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::WeighingEntriesController#create")
    end
  end

  describe "PUT /api/weighing_entries/:id" do
    it "updates a weighing entry and returns it" do
      put "/api/weighing_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::WeighingEntriesController#update")
    end
  end

  describe "DELETE /api/weighing_entries/:id" do
    it "deletes a weighing entry and returns it" do
      delete "/api/weighing_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("Api::WeighingEntriesController#destroy")
    end
  end
end
