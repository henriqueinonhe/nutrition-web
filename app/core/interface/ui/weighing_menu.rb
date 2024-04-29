# frozen_string_literal: true

class Interface::Ui::WeighingMenu
  def render
    <<~HEREDOC
      Weighing Module:

      1. List weighings
      2. Add weighing
      3. Delete weighing
      0. Back
    HEREDOC
  end

  def parse_input(input)
    command_matrix = {
      "1" => :ListWeighings,
      "2" => :StartAddWeighingMenu,
      "3" => :StartDeleteWeighingMenu,
      "0" => :Back
    }

    command_matrix[input]
  end
end
