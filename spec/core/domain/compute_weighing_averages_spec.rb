# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::ComputeWeighingAverages do
  context "when argument is nil" do
    it "raises an error" do
      expect { Domain::ComputeWeighingAverages.call(nil) }.to raise_error do |error|
        expect(error.tags).to include(:ComputeWeighingAverages)
        expect(error.tags).to include(:InvalidEntries)
      end
    end
  end

  context "when some entries are NOT weighing entries" do
    it "raises an error" do
      entries = [
        Domain::WeighingEntry.new(
          id: Random.uuid,
          date: Time.zone.now,
          weight_in_kg: 68.3
        ),
        "Not a weighing entry"
      ]

      expect { Domain::ComputeWeighingAverages.call(entries) }.to raise_error do |error|
        expect(error.tags).to include(:ComputeWeighingAverages)
        expect(error.tags).to include(:InvalidEntries)
      end
    end
  end

  context "when all entries are weighing entries" do
    it "returns the correct averages" do
      weights = [
        68.3,
        67,
        67.8,
        68,
        69,
        72,
        71.3,
        71.5
      ]

      weighings = weights.map do |weight|
        Domain::WeighingEntry.new(
          id: Random.uuid,
          date: Time.zone.now,
          weight_in_kg: weight
        )
      end

      actual_averages = Domain::ComputeWeighingAverages.call(weighings)

      expected_averages = [
        nil,
        nil,
        nil,
        nil,
        68.02,
        68.76,
        69.62,
        70.36
      ]

      zipped_averages = expected_averages.zip(actual_averages)

      epsilon = 0.1

      expect(actual_averages.length).to eq(expected_averages.length)

      expect(zipped_averages).to all(satisfy { |expected, actual| ((expected || 0) - (actual || 0)).abs < epsilon })
    end
  end
end
