# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::MealEntry do
  describe "#initialize" do
    context "when id is not a string" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            id: 1
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidId) }).to be(true)
          end
        end
      end
    end

    context "when id is an empty string" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            id: ""
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidId) }).to be(true)
          end
        end
      end
    end

    context "when date is not a Time" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            date: 1
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidDate) }).to be(true)
          end
        end
      end
    end

    context "when food is not a Food" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            food: { id: 1 }
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidFood) }).to be(true)
          end
        end
      end
    end

    context "when weight_in_grams is not a number" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            weight_in_grams: "12g"
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidWeightInGrams) }).to be(true)
          end
        end
      end
    end

    context "when weight_in_grams is zero" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            weight_in_grams: 0
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidWeightInGrams) }).to be(true)
          end
        end
      end
    end

    context "when weight_in_grams is negative" do
      it "raises an error" do
        expect do
          TestUtils::MealEntryFactory.call(
            weight_in_grams: -10
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error).to be_a(Errors::Error)
            expect(error.tag?(:MealEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors.any? { |e| e.tags.include?(:InvalidWeightInGrams) }).to be(true)
          end
        end
      end
    end
  end

  describe "#stats" do
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

      meal_entry = Domain::MealEntry.new(
        id: "id",
        date: Time.zone.now,
        food:,
        weight_in_grams: 27
      )

      stats = meal_entry.stats

      {
        meal_entry:,
        stats:
      }
    end

    context "when calculating the stats of a meal entry" do
      it "Returns the correct stats" do
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
