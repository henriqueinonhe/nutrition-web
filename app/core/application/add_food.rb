# frozen_string_literal: true

require "random/formatter"

class Application::AddFood
  def initialize(foods_hash:, foods_persistence:)
    @foods_hash = foods_hash
    @foods_persistence = foods_persistence
  end

  def call(
    name:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )

    check_duplicate_food_name(name)

    food = Domain::Food.new(
      id: Random.uuid,
      name:,
      kcal_per_gram:,
      carbohydrates_in_grams_per_gram:,
      protein_in_grams_per_gram:,
      total_fat_in_grams_per_gram:,
      fibers_in_grams_per_gram:,
      sodium_in_mg_per_gram:
    )

    updated_foods_list = @foods_hash.to_a.map { |_, f| f } + [food]

    @foods_persistence.store(updated_foods_list)

    @foods_hash[food.id] = food

    food
  end

  private

  def check_duplicate_food_name(name)
    has_duplicate = @foods_hash.to_a.any? { |_, food| food.name == name }

    return unless has_duplicate

    raise Errors::Error.new(
      msg: "Food with name #{name} already exists",
      tags: %i[ValidationError DuplicateName]
    )
  end
end
