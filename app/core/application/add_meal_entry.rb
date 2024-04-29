# frozen_string_literal: true

class Application::AddMealEntry
  def initialize(
    meal_entries_hash:,
    meal_entries_persistence:
  )
    @meal_entries_hash = meal_entries_hash
    @meal_entries_persistence = meal_entries_persistence
  end

  def call; end
end
