# frozen_string_literal: true

require "random/formatter"

class Application::AddFood
  def initialize(food_repository:)
    @food_repository = food_repository
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

    @food_repository.add(
      name:,
      kcal_per_gram:,
      carbohydrates_in_grams_per_gram:,
      protein_in_grams_per_gram:,
      total_fat_in_grams_per_gram:,
      fibers_in_grams_per_gram:,
      sodium_in_mg_per_gram:
    )
  rescue Errors::Error => e
    if e.tag?(:FoodConstructionFailure) || (e.tag?(:FoodRepositoryError) && e.tag?(:FailedToAdd))
      raise Errors::Error.new(
        msg: e.msg,
        tags: [:ValidationError]
      )
    end

    raise e
  end
end
