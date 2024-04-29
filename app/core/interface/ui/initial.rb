# frozen_string_literal: true

class Interface::Ui::Initial
  def render
    <<~HEREDOC
      Nutrition Tracker

      1. Weighing Module
      0. Exit
    HEREDOC
  end

  def parse_input(input)
    case input
    when "1"
      [:StartWeighingMenu, nil]
    when "0"
      [:Exit, nil]
    end
  end
end
