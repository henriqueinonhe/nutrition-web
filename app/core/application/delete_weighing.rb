# frozen_string_literal: true

class Application::DeleteWeighing
  def initialize(weighing_entry_repository:)
    @weighing_entry_repository = weighing_entry_repository
  end

  def call(weighing_id)
    @weighing_entry_repository.delete(weighing_id)
  rescue Errors::Error => e
    if e.tag?(:FailedToDelete) && e.tag?(:WeighingEntryRepository) && e.tag?(:WeighingEntryNotFound)
      raise Errors::Error.new(
        msg: e.msg,
        tags: [:ValidationError]
      )
    end

    raise e
  end
end
