# frozen_string_literal: true

class Application::AddWeighing
  def initialize(weighing_entry_persistence:)
    @weighing_entry_persistence = weighing_entry_persistence
  end

  def call(
    date:,
    weight_in_kg:
  )
    weighings = @weighing_entry_persistence.retrieve

    begin
      new_weighing_entry = Domain::WeighingEntry.new(
        id: Random.uuid,
        date:,
        weight_in_kg:
      )
    rescue Errors::Error => e
      if e.tag?(:WeighingEntry) && e.tag?(:ConstructionFailure)
        raise Errors::Error.new(
          msg: e.msg,
          tags: [:ValidationError]
        )
      end

      raise e
    end

    weighings << new_weighing_entry

    @weighing_entry_persistence.store(weighings)

    weighings.zip(Domain::ComputeWeighingAverages.call(weighings))
  end
end
