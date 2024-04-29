# frozen_string_literal: true

class Interface::Transitions::DeleteWeighing
  def initialize(print_weighings:, delete_weighing:)
    @print_weighings = print_weighings
    @delete_weighing = delete_weighing
  end

  def call(position)
    weighing_to_delete = @weighings[position - 1]

    entries = @delete_weighing.call(weighing_to_delete.id)

    @print_weighings.call(entries)

    :WeighingMenu
  end
end
