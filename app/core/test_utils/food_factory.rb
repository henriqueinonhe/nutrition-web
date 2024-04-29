# frozen_string_literal: true

require "faker"

module TestUtils::FoodFactory
  def self.call(**overrides)
    default_values = {
      id: Random.uuid,
      name: Faker::Food.dish,
      kcal_per_gram: Random.rand(0..5),
      carbohydrates_in_grams_per_gram: Random.rand(0..0.5),
      protein_in_grams_per_gram: Random.rand(0..0.5),
      total_fat_in_grams_per_gram: Random.rand(0..0.5),
      fibers_in_grams_per_gram: Random.rand(0..0.5),
      sodium_in_mg_per_gram: Random.rand(0..10)
    }

    result = default_values.merge(overrides)

    Domain::Food.new(**result)
  end
end
