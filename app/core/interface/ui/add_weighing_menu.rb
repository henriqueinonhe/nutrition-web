# frozen_string_literal: true

class Interface::Ui::AddWeighingMenu
  def render
    <<~HEREDOC
      Write the weight (in Kg)
    HEREDOC
  end

  def parse_input(input)
    weight_in_kg = input.to_f

    [:AddWeighing, weight_in_kg]
  end
end
