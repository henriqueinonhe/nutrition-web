# frozen_string_literal: true

module TestUtils::WeighingEntryFactory
  def self.call(**overrides)
    default = {
      id: Random.uuid,
      date: Time.zone.now,
      weight_in_kg: Random.rand(10..100)
    }

    result = default.merge(overrides)

    Domain::WeighingEntry.new(**result)
  end
end
