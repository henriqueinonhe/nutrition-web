# frozen_string_literal: true

class Interface::Transitions::ListWeighings
  def initialize(list_weighings:, print_weighings:)
    @list_weighings = list_weighings
    @print_weighings = print_weighings
  end

  def call(*)
    entries = @list_weighings.call

    @print_weighings.call(entries)

    :WeighingMenu
  end
end
