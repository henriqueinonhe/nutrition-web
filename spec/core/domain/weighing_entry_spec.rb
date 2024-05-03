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
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors[0].tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.sub_errors[0].tag?(:InvalidId)).to be(true)
          end
        end
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
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors[0].tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.sub_errors[0].tag?(:InvalidId)).to be(true)
          end
        end
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
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors[0].tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.sub_errors[0].tag?(:InvalidDate)).to be(true)
          end
        end
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
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors[0].tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.sub_errors[0].tag?(:InvalidWeight)).to be(true)
          end
        end
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
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(1)
            expect(error.sub_errors[0].tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.sub_errors[0].tag?(:InvalidWeight)).to be(true)
          end
        end
      end
    end

    context "when creating an entry with a few invalid attributes" do
      it "raises an exception with aggregated errors" do
        expect do
          Domain::WeighingEntry.new(
            id: "",
            date: 13,
            weight_in_kg: -20
          )
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryConstructionFailure)).to be(true)
            expect(error.sub_errors.size).to eq(3)

            expect(
              error.sub_errors.any? do |e|
                e.tag?(:WeighingEntryValidationError) && e.tag?(:InvalidId)
              end
            ).to be(true)

            expect(
              error.sub_errors.any? do |e|
                e.tag?(:WeighingEntryValidationError) && e.tag?(:InvalidWeight)
              end
            ).to be(true)

            expect(
              error.sub_errors.any? do |e|
                e.tag?(:WeighingEntryValidationError) && e.tag?(:InvalidDate)
              end
            ).to be(true)
          end
        end
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

  describe "#date=" do
    def setup
      weighing_entry = Domain::WeighingEntry.new(
        id: "1",
        date: Time.zone.now,
        weight_in_kg: 37
      )

      {
        weighing_entry:
      }
    end

    context "when passing an invalid date" do
      it "raises an exception" do
        results = setup

        weighing_entry = results[:weighing_entry]

        expect do
          weighing_entry.date = "asdasd"
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.tag?(:InvalidDate)).to be(true)
          end
        end
      end
    end

    context "when passing a valid date" do
      it "updates the date" do
        results = setup

        weighing_entry = results[:weighing_entry]

        new_date = Time.new(2021, 1, 1)

        weighing_entry.date = new_date

        expect(weighing_entry.date).to eq(new_date)
      end
    end
  end

  describe "#weight_in_kg=" do
    def setup
      weighing_entry = Domain::WeighingEntry.new(
        id: "1",
        date: Time.zone.now,
        weight_in_kg: 37
      )

      {
        weighing_entry:
      }
    end

    context "when passing an invalid weight" do
      it "raises an exception" do
        results = setup

        weighing_entry = results[:weighing_entry]

        expect do
          weighing_entry.weight_in_kg = -20
        end.to raise_error do |error|
          aggregate_failures do
            expect(error.tag?(:WeighingEntryValidationError)).to be(true)
            expect(error.tag?(:InvalidWeight)).to be(true)
          end
        end
      end
    end

    context "when passing a valid weight" do
      it "updates the weight" do
        results = setup

        weighing_entry = results[:weighing_entry]

        new_weight = 20

        weighing_entry.weight_in_kg = new_weight

        expect(weighing_entry.weight_in_kg).to eq(new_weight)
      end
    end
  end
end
