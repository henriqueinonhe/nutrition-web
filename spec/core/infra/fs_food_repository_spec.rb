# frozen_string_literal: true

require "json"
require "rails_helper"

RSpec.describe Infra::FsFoodRepository do
  def setup
    food_repository = Infra::FsFoodRepository.new(
      foods_file_path: "./storage/foods.test.json"
    )

    existing_foods = TestUtils::ArrayFactory.call(
      -> { TestUtils::FoodFactory.call },
      10
    )

    food_repository.store(existing_foods)

    {
      food_repository:,
      existing_foods:
    }
  end

  describe "when storing and retrieving foods" do
    def second_setup
      result = setup

      existing_foods = result[:existing_foods]
      food_repository = result[:food_repository]

      retrieved_foods = food_repository.retrieve_all

      {
        existing_foods:,
        food_repository:,
        retrieved_foods:
      }
    end

    it "retrieves the same foods that were stored" do
      result = second_setup

      existing_foods = result[:existing_foods]
      retrieved_foods = result[:retrieved_foods]

      expect(existing_foods).to match_array(retrieved_foods)
    end
  end

  describe "#add" do
    context "when food name is duplicated" do
      it "raises an error" do
        result = setup
        food_repository = result[:food_repository]
        existing_foods = result[:existing_foods]

        expect do
          food_repository.add(
            name: existing_foods.first.name,
            kcal_per_gram: 1,
            carbohydrates_in_grams_per_gram: 1,
            protein_in_grams_per_gram: 1,
            total_fat_in_grams_per_gram: 1,
            fibers_in_grams_per_gram: 1,
            sodium_in_mg_per_gram: 1
          )
        end.to raise_error do |error|
          expect(error).to be_a(Errors::Error)
          expect(error.tags).to match_array(%i[FoodRepositoryError FailedToAdd DuplicateName])
        end
      end
    end

    context "when food name is not duplicated" do
      def second_setup
        result = setup
        food_repository = result[:food_repository]
        existing_foods = result[:existing_foods]

        new_food = food_repository.add(
          name: "New food",
          kcal_per_gram: 1,
          carbohydrates_in_grams_per_gram: 1,
          protein_in_grams_per_gram: 1,
          total_fat_in_grams_per_gram: 1,
          fibers_in_grams_per_gram: 1,
          sodium_in_mg_per_gram: 1
        )

        retrieved_foods = food_repository.retrieve_all

        {
          existing_foods:,
          new_food:,
          retrieved_foods:
        }
      end

      it "adds food" do
        result = second_setup

        existing_foods = result[:existing_foods]
        new_food = result[:new_food]
        retrieved_foods = result[:retrieved_foods]

        expect(retrieved_foods).to match_array(existing_foods + [new_food])
      end
    end
  end

  describe "#find_by_id" do
    context "when food exists" do
      def second_setup
        result = setup
        food_repository = result[:food_repository]
        existing_foods = result[:existing_foods]

        food_to_find = existing_foods.first

        found_food = food_repository.find_by_id(food_to_find.id)

        {
          found_food:,
          food_to_find:
        }
      end

      it "returns the food" do
        result = second_setup

        found_food = result[:found_food]
        food_to_find = result[:food_to_find]

        expect(found_food).to eq(food_to_find)
      end
    end

    context "when food does not exist" do
      def second_setup
        result = setup
        food_repository = result[:food_repository]

        found_food = food_repository.find_by_id("non-existent-id")

        {
          found_food:
        }
      end

      it "returns nil" do
        result = second_setup
        found_food = result[:found_food]

        expect(found_food).to be_nil
      end
    end
  end

  describe "#edit" do
    context "when food exists" do
      def second_setup
        result = setup
        food_repository = result[:food_repository]
        existing_foods = result[:existing_foods]

        food_to_edit = existing_foods.sample

        edited_food = food_repository.edit(
          id: food_to_edit.id,
          kcal_per_gram: 2,
          carbohydrates_in_grams_per_gram: 2,
          protein_in_grams_per_gram: 2,
          total_fat_in_grams_per_gram: 2,
          fibers_in_grams_per_gram: 2,
          sodium_in_mg_per_gram: 2
        )

        retrieved_foods = food_repository.retrieve_all

        {
          existing_foods:,
          edited_food:,
          food_to_edit:,
          retrieved_foods:
        }
      end

      it "edits the food" do
        result = second_setup

        edited_food = result[:edited_food]
        food_to_edit = result[:food_to_edit]
        existing_foods = result[:existing_foods]
        retrieved_foods = result[:retrieved_foods]

        expect(retrieved_foods).to match_array(existing_foods.map do |food|
          if food == food_to_edit
            edited_food
          else
            food
          end
        end)
      end
    end

    context "when food does not exist" do
      it "raises an error" do
        result = setup
        food_repository = result[:food_repository]

        expect do
          food_repository.edit(
            id: "non-existent-id",
            kcal_per_gram: 1,
            carbohydrates_in_grams_per_gram: 1,
            protein_in_grams_per_gram: 1,
            total_fat_in_grams_per_gram: 1,
            fibers_in_grams_per_gram: 1,
            sodium_in_mg_per_gram: 1
          )
        end.to raise_error do |error|
          expect(error).to be_a(Errors::Error)
          expect(error.tags).to match_array(%i[FoodRepositoryError FailedToEdit FoodNotFound])
        end
      end
    end
  end
end
