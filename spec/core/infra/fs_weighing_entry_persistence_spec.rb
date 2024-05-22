# frozen_string_literal: true

require "rails_helper"

RSpec.describe Infra::FsWeighingEntryPersistence do
  def setup
    weighing_entry_persistence = Infra::FsWeighingEntryPersistence.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    existing_weighings = TestUtils::ArrayFactory.call(
      -> { TestUtils::WeighingEntryFactory.call },
      10
    )

    weighing_entry_persistence.store(existing_weighings)

    {
      weighing_entry_persistence:,
      existing_weighings:
    }
  end

  context "when storing and retrieving weighings" do
    def second_setup
      result = setup

      weighing_entry_persistence = result[:weighing_entry_persistence]
      existing_weighings = result[:existing_weighings]

      retrieved_weighings = weighing_entry_persistence.retrieve_all

      {
        existing_weighings:,
        retrieved_weighings:
      }
    end

    it "retrieves all stored weighings" do
      result = second_setup

      existing_weighings = result[:existing_weighings]
      retrieved_weighings = result[:retrieved_weighings]

      expect(existing_weighings).to match_array(retrieved_weighings)
    end
  end

  describe "#find_by_id" do
    def second_setup
      results = setup
      weighing_entry_persistence = results[:weighing_entry_persistence]
      existing_weighings = results[:existing_weighings]

      some_entry = existing_weighings.sample
      found_entry = weighing_entry_persistence.find_by_id(some_entry.id)

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
