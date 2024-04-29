# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::WeighingEntry do
  context "when creating a weighing entry with an invalid id" do
    it "raises an exception" do
      expect do
        Domain::WeighingEntry.new(
          id: 1,
          date: Time.zone.now,
          weight_in_kg: 20
        )
      end.to raise_error(
        having_attributes(
          tags: %i[PreconditionViolation ConstructionFailure WeighingEntry InvalidId]
        )
      )
    end
  end

  context "when creating a weighing entry with an invalid date" do
    it "raises an exception" do
      expect do
        Domain::WeighingEntry.new(
          id: "1",
          date: "asdasd",
          weight_in_kg: 20
        )
      end.to raise_error(
        having_attributes(
          tags: %i[PreconditionViolation ConstructionFailure WeighingEntry InvalidDate]
        )
      )
    end
  end

  context "when creating a weighing entry with zero weight" do
    it "raises an exception" do
      expect do
        Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: 0
        )
      end.to raise_error(
        having_attributes(
          tags: %i[PreconditionViolation ConstructionFailure WeighingEntry InvalidWeight]
        )
      )
    end
  end

  context "when creating a weighing entry with negative weight" do
    it "raises an exception" do
      expect do
        Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: -20
        )
      end.to raise_error(
        having_attributes(
          tags: %i[PreconditionViolation ConstructionFailure WeighingEntry InvalidWeight]
        )
      )
    end
  end

  context "when creating a valid weighing entry" do
    def setup
      Domain::WeighingEntry.new(
        id: "1",
        date: Time.zone.now,
        weight_in_kg: 37
      )
    end

    it "does not throw an exception" do
      expect { setup }.not_to raise_error
    end
  end
end
