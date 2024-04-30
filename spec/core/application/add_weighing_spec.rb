# frozen_string_literal: true

require "rails_helper"

RSpec.describe Application::AddWeighing do
  def setup
    weighing_entry_persistence = Infra::FsWeighingEntryPersistence.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    existing_weighings = TestUtils::ArrayFactory.call(
      -> { TestUtils::WeighingEntryFactory.call },
      10
    )

    weighing_entry_persistence.store(existing_weighings)

    add_weighing = Application::AddWeighing.new(
      weighing_entry_persistence:
    )

    {
      existing_weighings:,
      add_weighing:,
      weighing_entry_persistence:
    }
  end

  it "adds a weighing entry" do
    result = setup

    existing_weighings = result[:existing_weighings]
    add_weighing = result[:add_weighing]

    entries = add_weighing.call(70)

    # TODO: Improve this
    expect(entries.length).to eq(existing_weighings.length + 1)
  end
end
