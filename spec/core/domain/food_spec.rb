# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::Food do
  context "when creating a food" do
    # TODO
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
