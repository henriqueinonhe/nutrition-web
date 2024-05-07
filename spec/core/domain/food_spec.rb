# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::Food do
  describe "#initialize" do
    context "when id is an empty string" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            id: ""
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidId) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when id is not a string" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            id: 34
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidId) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when name is an empty string" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            name: ""
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidName) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when name is not a string" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            name: 4
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidName) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when kcal_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            kcal_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidKcalPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when kcal_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            kcal_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidKcalPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when carbohydrates_in_grams_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            carbohydrates_in_grams_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidCarbohydratesInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when carbohydrates_in_grams_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            carbohydrates_in_grams_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidCarbohydratesInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when protein_in_grams_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            protein_in_grams_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidProteinInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when protein_in_grams_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            protein_in_grams_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidProteinInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when total_fat_in_grams_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            total_fat_in_grams_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidTotalFatInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when total_fat_in_grams_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            total_fat_in_grams_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidTotalFatInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when fibers_in_grams_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            fibers_in_grams_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidFibersInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when fibers_in_grams_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            fibers_in_grams_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidFibersInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when sodium_in_mg_per_gram is not a number" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            sodium_in_mg_per_gram: "34"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidSodiumInMgPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when sodium_in_mg_per_gram is negative" do
      it "raises an error" do
        expect do
          TestUtils::FoodFactory.call(
            sodium_in_mg_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidSodiumInMgPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end

    context "when there are multiple validation errors" do
      it "raises an error with all of them" do
        expect do
          TestUtils::FoodFactory.call(
            id: "",
            total_fat_in_grams_per_gram: "asdas",
            sodium_in_mg_per_gram: -3
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:FoodConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(3)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidId) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidTotalFatInGramsPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:InvalidSodiumInMgPerGram) }).to be(true)
            expect(error.sub_errors.any? { |e| e.tag?(:FoodValidationError) }).to be(true)
          end
        end
      end
    end
  end

  describe "#stats_for_weight" do
    context "when calculating stats for 27 grams of food" do
      def setup
        food = Domain::Food.new(
          id: "id",
          name: "Requeijão",
          kcal_per_gram: 1.57,
          carbohydrates_in_grams_per_gram: 0.018,
          protein_in_grams_per_gram: 0.12,
          total_fat_in_grams_per_gram: 0.11,
          fibers_in_grams_per_gram: 0.0,
          sodium_in_mg_per_gram: 1.47
        )

        stats = food.stats_for_weight(27)

        {
          food:,
          stats:
        }
      end

      it "returns the correct stats" do
        result = setup
        stats = result[:stats]

        epsilon = 0.1

        aggregate_failures do
          expect(stats[:kcal]).to be_within(epsilon).of(42.39)
          expect(stats[:carbohydrates_in_grams]).to be_within(epsilon).of(0.486)
          expect(stats[:protein_in_grams]).to be_within(epsilon).of(3.24)
          expect(stats[:total_fat_in_grams]).to be_within(epsilon).of(2.97)
          expect(stats[:fibers_in_grams]).to be_within(epsilon).of(0.0)
          expect(stats[:sodium_in_mg]).to be_within(epsilon).of(39.69)
        end
      end
    end
  end
end
