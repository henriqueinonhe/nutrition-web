# frozen_string_literal: true

require "rails_helper"

RSpec.describe Application::AddWeighing do
  def setup
    weighing_entry_repository = Infra::FsWeighingEntryRepository.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    existing_weighings = TestUtils::ArrayFactory.call(
      -> { TestUtils::WeighingEntryFactory.call },
      10
    )

    weighing_entry_repository.store(existing_weighings)

    new_entry = weighing_entry_repository.add(
      date: Time.now,
      weight_in_kg: 70
    )

    stored_entries = weighing_entry_repository.retrieve_all

    {
      existing_weighings:,
      weighing_entry_repository:,
      stored_entries:,
      new_entry:
    }
  end

  it "adds a weighing entry" do
    result = setup

    existing_weighings = result[:existing_weighings]
    stored_entries = result[:stored_entries]
    new_entry = result[:new_entry]

    expect(stored_entries).to match_array(existing_weighings + [new_entry])
  end
end
