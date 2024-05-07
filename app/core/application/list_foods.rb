# frozen_string_literal: true

class Application::ListFoods
  def initialize(food_repository:)
    @food_repository = food_repository
  end

  def call
    @food_repository.retrieve_all
  end
end
