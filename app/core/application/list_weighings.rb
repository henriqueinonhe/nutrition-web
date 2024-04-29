# frozen_string_literal: true

class Application::ListWeighings
  def initialize(weighing_entry_persistence:)
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call
    weighing_entries = @weighing_entry_persistence.retrieve
    weighing_entries.zip(Domain::ComputeWeighingAverages.call(weighing_entries))
  end
end
