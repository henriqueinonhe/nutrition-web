# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::WeighingEntry do
  describe "#initialize" do
    context "when creating a weighing entry with a non-string id" do
      it "raises an exception" do
        expect do
          Domain::WeighingEntry.new(
            id: 1,
            date: Time.zone.now,
            weight_in_kg: 20
          )
        end.to raise_error(
          having_attributes(
            tags: %i[WeighingEntryConstructionFailure InvalidId]
          )
        )
      end
    end

    context "when creating a weighing entry with an empty id" do
      it "raises an exception" do
        expect do
          Domain::WeighingEntry.new(
            id: "",
            date: Time.zone.now,
            weight_in_kg: 20
          )
        end.to raise_error(
          having_attributes(
            tags: %i[WeighingEntryConstructionFailure InvalidId]
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
            tags: %i[WeighingEntryConstructionFailure InvalidDate]
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
            tags: %i[WeighingEntryConstructionFailure InvalidWeight]
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
            tags: %i[WeighingEntryConstructionFailure InvalidWeight]
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

  describe "#==" do
    context "when comparing two weighing entries with the same attributes" do
      def setup
        first = Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: 37
        )
        second = Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: 37
        )

        {
          first:,
          second:
        }
      end

      it "returns true" do
        results = setup

        first = results[:first]
        second = results[:second]

        expect(first == second).to be(true)
        expect(first).not_to eql(second)
      end
    end

    context "when comparing two weighing entries with different attributes" do
      def setup
        first = Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: 37
        )
        second = Domain::WeighingEntry.new(
          id: "2",
          date: Time.zone.now,
          weight_in_kg: 37
        )

        {
          first:,
          second:
        }
      end

      it "returns false" do
        results = setup

        first = results[:first]
        second = results[:second]

        expect(first == second).to be(false)
      end
    end

    context "when comparing a weighing entry with another object that responds to the same 'attributes'" do
      def setup
        first = Domain::WeighingEntry.new(
          id: "1",
          date: Time.zone.now,
          weight_in_kg: 37
        )
        second = Class.new do
          def id
            "1"
          end

          def date
            Time.zone.now
          end
        end

        {
          first:,
          second:
        }
      end

      it "returns false" do
        results = setup

        first = results[:first]
        second = results[:second]

        expect(first == second).to be(false)
      end
    end
  end
end
