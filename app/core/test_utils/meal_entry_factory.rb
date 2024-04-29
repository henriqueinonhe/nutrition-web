# frozen_string_literal: true

module TestUtils::MealEntryFactory
  def self.call(**overrides)
    default_values = {
      id: Random.uuid,
      date: Time.zone.now,
      food: TestUtils::FoodFactory.call,
      weight_in_grams: Random.rand(1...500)
    }

    result = default_values.merge(overrides)

    Domain::MealEntry.new(**result)
  end
end
