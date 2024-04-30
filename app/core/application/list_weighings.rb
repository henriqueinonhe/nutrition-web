# frozen_string_literal: true

class Application::ListWeighings
  def initialize(weighing_entry_persistence:)
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call
    weighing_entries = @weighing_entry_persistence.retrieve
    sorted_weighing_entries = weighing_entries.sort_by(&:date)
    sorted_weighing_entries.zip(Domain::ComputeWeighingAverages.call(sorted_weighing_entries))
  end
end
