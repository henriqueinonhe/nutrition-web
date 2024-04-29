# frozen_string_literal: true

class Application::EditWeighing
  def initialize(
    weighing_entry_repository:
  )
    @weighing_entry_repository = weighing_entry_repository
  end

  def call(
    id:,
    date:,
    weight_in_kg:
  )
    @weighing_entry_repository.edit(
      id:,
      date:,
      weight_in_kg:
    )
  end
end
