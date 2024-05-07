# frozen_string_literal: true

class Application::DeleteFood
  def initialize(food_repository:)
    @foods_persistence = food_repository
  end

  def call(
    food_id
  )
    @foods_persistence.delete(food_id)
  rescue Errors::Error => e
    if e.tag?(:FoodRepositoryError) && e.tag?(:FailedToDelete)
      raise Errors::Error.new(
        msg: e.msg,
        tags: [:ValidationError]
      )
    end

    raise e
  end
end
