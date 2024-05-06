# frozen_string_literal: true

class Application::AddWeighing
  def initialize(weighing_entry_repository:)
    @weighing_entry_repository = weighing_entry_repository
  end

  def call(
    date:,
    weight_in_kg:
  )

    @weighing_entry_repository.add(
      date:,
      weight_in_kg:
    )
  rescue Errors::Error => e
    if e.tag?(:WeighingEntryConstructionFailure)
      raise Errors::Error.new(
        msg: e.msg,
        tags: [:ValidationError],
        sub_errors: e.sub_errors
      )
    end

    raise e
  end
end
