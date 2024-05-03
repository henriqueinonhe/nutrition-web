# frozen_string_literal: true

require "rails_helper"

RSpec.describe Application::ListWeighings do
  def setup
    weighing_entry_repository = Infra::FsWeighingEntryRepository.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    weighings = [
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 68.3
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 67
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 67.8
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 68
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 69
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 72
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 71.3
      ),
      TestUtils::WeighingEntryFactory.call(
        weight_in_kg: 71.5
      )
    ]

    list_weighings = Application::ListWeighings.new(
      weighing_entry_repository:
    )

    weighing_entry_repository.store(weighings)

    {
      weighings:,
      list_weighings:
    }
  end

  it "returns a list of weighings with averages" do
    result = setup

    weighings = result[:weighings]
    list_weighings = result[:list_weighings]

    expected = [
      [weighings[0], nil],
      [weighings[1], nil],
      [weighings[2], nil],
      [weighings[3], nil],
      [weighings[4], 68.02],
      [weighings[5], 68.76],
      [weighings[6], 69.62],
      [weighings[7], 70.36]
    ]

    actual = list_weighings.call

    expect(expected.length).to be(actual.length)

    expected.each_index do |index|
      expect(expected[index][0]).to eq(actual[index][0])
      expect(expected[index][1] || 0).to be_within(0.1).of(actual[index][1] || 0)
    end
  end
end
