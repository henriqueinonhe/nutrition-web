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
end
