# frozen_string_literal: true

require "rails_helper"

RSpec.describe Infra::FsMealEntryPersistence do
  context "when storing and retrieving meal entries" do
    def setup
      meal_entry_persistence = Infra::FsMealEntryPersistence.new(
        meal_entries_file_path: "./storage/meal_entries.test.json"
      )

      foods_hash = {
        "1" => TestUtils::FoodFactory.call(id: "1"),
        "2" => TestUtils::FoodFactory.call(id: "2")
      }

      meal_entries = [
        TestUtils::MealEntryFactory.call(food: foods_hash["1"]),
        TestUtils::MealEntryFactory.call(food: foods_hash["2"])
      ]

      meal_entry_persistence.store(meal_entries)

      retrieved_meal_entries = meal_entry_persistence.retrieve(foods_hash:)

      {
        meal_entries:,
        retrieved_meal_entries:
      }
    end

    it "retrieves the same meal entries that were stored" do
      result = setup

      meal_entries = result[:meal_entries]
      retrieved_meal_entries = result[:retrieved_meal_entries]

      expect(retrieved_meal_entries).to eq(meal_entries)
    end
  end
end
