require "rails_helper"

RSpec.describe "Weighing Entries" do
  describe "GET /weighing_entries" do
    it "returns all weighing entries" do
      get "/weighing_entries"

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body[:handler]).to eq("WeighingEntriesController#index")
    end
  end

  describe "POST /weighing_entries" do
    it "creates a weighing entry and returns it" do
      post "/weighing_entries"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("WeighingEntriesController#create")
    end
  end

  describe "PUT /weighing_entries/:id" do
    it "updates a weighing entry and returns it" do
      put "/weighing_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("WeighingEntriesController#update")
    end
  end

  describe "DELETE /weighing_entries/:id" do
    it "deletes a weighing entry and returns it" do
      delete "/weighing_entries/1"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("WeighingEntriesController#destroy")
    end
  end
end
