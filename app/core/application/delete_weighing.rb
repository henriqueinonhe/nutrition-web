# frozen_string_literal: true

class Application::DeleteWeighing
  def initialize(weighing_entry_persistence:)
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call(weighing_id)
    weighings = @weighing_entry_persistence.retrieve

    weighings.filter! { |weighing| weighing.id != weighing_id }

    @weighing_entry_persistence.store(weighings)

    weighings.zip(Domain::ComputeWeighingAverages.call(weighings))
  end
end
