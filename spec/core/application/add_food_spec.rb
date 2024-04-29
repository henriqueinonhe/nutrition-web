# frozen_string_literal: true

require "rails_helper"

RSpec.describe Application::AddFood do
  context "when food name is duplicated" do
    def setup
      foods_hash = {
        "1" => TestUtils::FoodFactory.call(
          id: "1",
          name: "Apple"
        ),
        "2" => TestUtils::FoodFactory.call(
          id: "2",
          name: "Banana"
        )
      }

      foods_persistence = Infra::FsFoodPersistence.new(
        foods_file_path: "./storage/foods.test.json"
      )

      add_food = Application::AddFood.new(foods_hash:, foods_persistence:)

      {
        foods_hash:,
        foods_persistence:,
        add_food:
      }
    end

    it "raises a validation error" do
      result = setup

      add_food = result[:add_food]

      expect do
        add_food.call(
          name: "Apple",
          kcal_per_gram: 1.52,
          carbohydrates_in_grams_per_gram: 0.14,
          protein_in_grams_per_gram: 3.01,
          total_fat_in_grams_per_gram: 0.21,
          fibers_in_grams_per_gram: 123,
          sodium_in_mg_per_gram: 0.01
        )
      end.to raise_error(
        having_attributes(
          tags: %i[ValidationError DuplicateName]
        )
      )
    end
  end

  context "when adding a new food" do
    def setup
      foods_hash = {
        "1" => TestUtils::FoodFactory.call(
          id: "1",
          name: "Apple"
        ),
        "2" => TestUtils::FoodFactory.call(
          id: "2",
          name: "Banana"
        )
      }

      foods_persistence = Infra::FsFoodPersistence.new(
        foods_file_path: "./storage/foods.test.json"
      )

      add_food = Application::AddFood.new(foods_hash:, foods_persistence:)

      {
        add_food:,
        foods_hash:,
        foods_persistence:
      }
    end

    it "adds the new food to the foods hash" do
      result = setup

      add_food = result[:add_food]
      foods_hash = result[:foods_hash]
      foods_persistence = result[:foods_persistence]

      new_food = add_food.call(
        name: "Orange",
        kcal_per_gram: 1.52,
        carbohydrates_in_grams_per_gram: 0.14,
        protein_in_grams_per_gram: 3.01,
        total_fat_in_grams_per_gram: 0.21,
        fibers_in_grams_per_gram: 123,
        sodium_in_mg_per_gram: 0.01
      )

      expect(foods_hash[new_food.id]).to eq(new_food)

      retrieved_foods = foods_persistence.retrieve

      expect(retrieved_foods).to eq(foods_hash.values)
    end
  end
end
