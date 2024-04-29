# frozen_string_literal: true

class Application::DeleteFood
  def initialize(foods_hash:, foods_persistence:)
    @foods_hash = foods_hash
    @foods_persistence = foods_persistence
  end

  def call(
    food_id
  )
    food_to_delete = @foods_hash[food_id]

    if food_to_delete.nil?
      raise Errors::Error.new(
        msg: "Food with id #{food_id} not found",
        tags: %i[ValidationError FoodNotFound]
      )
    end

    updated_foods_list = @foods_hash.to_a.map { |_, food| food }.reject { |food| food.id == food_id }

    @foods_persistence.store(updated_foods_list)

    @foods_hash.delete(food_id)

    food_to_delete
  end
end
