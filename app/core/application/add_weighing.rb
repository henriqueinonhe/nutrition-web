# frozen_string_literal: true

class Application::AddWeighing
  def initialize(weighing_entry_repository:)
    @weighing_entry_repository = weighing_entry_repository
  end

  def call(
    date:,
    weight_in_kg:
  )
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

    @weighing_entry_repository.add(new_weighing_entry)
  end
end
