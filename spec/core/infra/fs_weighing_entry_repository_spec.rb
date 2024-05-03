# frozen_string_literal: true

require "rails_helper"

RSpec.describe Infra::FsWeighingEntryRepository do
  def setup
    weighings_file_path = "./storage/weighings.test.json"
    weighing_entry_repository = Infra::FsWeighingEntryRepository.new(
      weighings_file_path:
    )

    existing_entries = TestUtils::ArrayFactory.call(
      -> { TestUtils::WeighingEntryFactory.call },
      10
    )

    weighing_entry_repository.store(existing_entries)

    {
      weighing_entry_repository:,
      existing_entries:
    }
  end

  describe "#retrieve_all" do
    def second_setup
      results = setup
      weighing_entry_repository = results[:weighing_entry_repository]
      existing_entries = results[:existing_entries]

      retrieved_entries = weighing_entry_repository.retrieve_all

      {
        retrieved_entries:,
        existing_entries:
      }
    end

    it "retrieves all stored weighing entries" do
      results = second_setup

      retrieved_entries = results[:retrieved_entries]
      existing_entries = results[:existing_entries]

      expect(retrieved_entries).to eq(existing_entries)
    end
  end

  describe "#find_by_id" do
    def second_setup
      results = setup
      weighing_entry_repository = results[:weighing_entry_repository]
      existing_entries = results[:existing_entries]

      some_entry = existing_entries.sample
      found_entry = weighing_entry_repository.find_by_id(some_entry.id)

      {
        found_entry:,
        some_entry:
      }
    end

    it "finds a stored weighing entry by its id" do
      results = second_setup

      found_entry = results[:found_entry]
      some_entry = results[:some_entry]

      expect(found_entry).to eq(some_entry)
    end
  end

  describe "#add" do
    def second_setup
      results = setup
      weighing_entry_repository = results[:weighing_entry_repository]
      existing_entries = results[:existing_entries]

      new_entry_date_date = Time.new
      new_entry_weight_in_kg = 70

      new_entry = weighing_entry_repository.add(
        date: new_entry_date_date,
        weight_in_kg: new_entry_weight_in_kg
      )

      saved_entries = weighing_entry_repository.retrieve_all

      {
        new_entry:,
        saved_entries:,
        new_entry_date_date:,
        new_entry_weight_in_kg:,
        existing_entries:
      }
    end

    it "adds a new weighing entry" do
      results = second_setup

      new_entry = results[:new_entry]
      saved_entries = results[:saved_entries]
      new_entry_date_date = results[:new_entry_date_date]
      new_entry_weight_in_kg = results[:new_entry_weight_in_kg]
      existing_entries = results[:existing_entries]

      aggregate_failures do
        expect(new_entry.date).to eq(new_entry_date_date)
        expect(new_entry.weight_in_kg).to eq(new_entry_weight_in_kg)
        expect(saved_entries).to match_array([new_entry] + existing_entries)
      end
    end
  end

  describe "#edit" do
    context "when there is no weighing entry associated with given id" do
      def second_setup
        results = setup
        weighing_entry_repository = results[:weighing_entry_repository]
        existing_entries = results[:existing_entries]

        non_existent_id = Random.uuid
        new_date = Time.new
        new_weight_in_kg = 70

        begin
          weighing_entry_repository.edit(
            id: non_existent_id,
            date: new_date,
            weight_in_kg: new_weight_in_kg
          )
        rescue Errors::Error => e
          error = e
        end

        {
          error:,
          non_existent_id:,
          new_date:,
          new_weight_in_kg:,
          existing_entries:
        }
      end

      it "raises an error" do
        results = second_setup

        error = results[:error]

        expect(error).to be_a(Errors::Error)
        expect(error.tags).to match_array(%i[WeighingEntryRepository WeighingEntryNotFound FailedToEdit])
      end
    end

    context "when there IS a weighing entry associated with given id" do
      def second_setup
        results = setup
        weighing_entry_repository = results[:weighing_entry_repository]
        existing_entries = results[:existing_entries]

        entry_to_edit = existing_entries.sample
        new_date = Time.new
        new_weight_in_kg = 70

        edited_entry = weighing_entry_repository.edit(
          id: entry_to_edit.id,
          date: new_date,
          weight_in_kg: new_weight_in_kg
        )

        saved_entries = weighing_entry_repository.retrieve_all

        {
          edited_entry:,
          saved_entries:,
          new_date:,
          new_weight_in_kg:,
          existing_entries:
        }
      end

      it "edits a stored weighing entry" do
        results = second_setup

        edited_entry = results[:edited_entry]
        saved_entries = results[:saved_entries]
        new_date = results[:new_date]
        new_weight_in_kg = results[:new_weight_in_kg]
        existing_entries = results[:existing_entries]

        aggregate_failures do
          expect(edited_entry.date).to eq(new_date)
          expect(edited_entry.weight_in_kg).to eq(new_weight_in_kg)
          expect(saved_entries).to match_array(
            existing_entries.map do |entry|
              entry.id == edited_entry.id ? edited_entry : entry
            end
          )
        end
      end
    end
  end

  describe "#delete" do
    context "when there is no weighing entry associated with given id" do
      def second_setup
        result = setup
        weighing_entry_repository = result[:weighing_entry_repository]
        existing_entries = result[:existing_entries]

        non_existent_id = Random.uuid

        stored_entries = weighing_entry_repository.retrieve_all

        {
          existing_entries:,
          weighing_entry_repository:,
          non_existent_id:,
          stored_entries:
        }
      end

      it "raises an error and leaves stored entries untouched" do
        results = second_setup

        existing_entries = results[:existing_entries]
        weighing_entry_repository = results[:weighing_entry_repository]
        non_existent_id = results[:non_existent_id]
        stored_entries = results[:stored_entries]

        expect do
          weighing_entry_repository.delete(non_existent_id)
        end
          .to raise_error do |error|
            aggregate_failures do
              expect(error).to be_a(Errors::Error)
              expect(error.tag?(:WeighingEntryRepository)).to be(true)
              expect(error.tag?(:WeighingEntryNotFound)).to be(true)
              expect(error.tag?(:FailedToDelete)).to be(true)
            end
          end

        expect(existing_entries).to eq(stored_entries)
      end
    end

    context "when there IS a weighing entry associated with given id" do
      def second_setup
        result = setup
        weighing_entry_repository = result[:weighing_entry_repository]
        existing_entries = result[:existing_entries]

        entry_to_delete = existing_entries.sample

        weighing_entry_repository.delete(entry_to_delete.id)

        stored_entries = weighing_entry_repository.retrieve_all

        {
          existing_entries:,
          weighing_entry_repository:,
          entry_to_delete:,
          stored_entries:
        }
      end

      it "deletes the corresponding weighing entry" do
        results = second_setup

        existing_entries = results[:existing_entries]
        entry_to_delete = results[:entry_to_delete]
        stored_entries = results[:stored_entries]

        expect(stored_entries).to eq(
          existing_entries.reject { |entry| entry.id == entry_to_delete.id }
        )
      end
    end
  end

  describe "#store" do
    def second_setup
      result = setup

      weighing_entry_repository = result[:weighing_entry_repository]
      existing_entries = result[:existing_entries]

      new_entries = TestUtils::ArrayFactory.call(
        -> { TestUtils::WeighingEntryFactory.call },
        10
      )

      weighing_entry_repository.store(new_entries)

      stored_entries = weighing_entry_repository.retrieve_all

      {
        weighing_entry_repository:,
        existing_entries:,
        stored_entries:,
        new_entries:
      }
    end

    it "stores the given weighing entries" do
      results = second_setup

      stored_entries = results[:stored_entries]
      new_entries = results[:new_entries]

      expect(stored_entries).to eq(new_entries)
    end
  end
end
