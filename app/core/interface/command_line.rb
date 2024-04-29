# frozen_string_literal: true

class Interface::CommandLine
  def initialize(
    reader:,
    writer:,
    initial_ui:,
    weighing_menu_ui:,
    add_weighing_menu_ui:,
    exit_transition:,
    list_weighings_transition:,
    add_weighing_transition:,
    delete_weighing_menu_ui:,
    delete_weighing_transition:
  )
    @reader = reader
    @writer = writer

    @state_matrix = {
      Initial: {
        ui: initial_ui,
        transitions: {
          StartWeighingMenu: proc { :WeighingMenu },
          Exit: exit_transition
        }
      },
      WeighingMenu: {
        ui: weighing_menu_ui,
        transitions: {
          ListWeighings: list_weighings_transition,
          StartAddWeighingMenu: proc { :AddWeighing },
          StartDeleteWeighingMenu: proc { :DeleteWeighing },
          Back: proc { :Initial }
        }
      },
      AddWeighing: {
        ui: add_weighing_menu_ui,
        transitions: {
          AddWeighing: add_weighing_transition
        }
      },
      DeleteWeighing: {
        ui: delete_weighing_menu_ui,
        transitions: {
          DeleteWeighing: delete_weighing_transition
        }
      }
    }
  end

  def start
    state = :Initial

    begin
      loop do
        break if state == :Finished

        render_ui(state)

        input = @reader.read

        command = parse_input(state, input)

        next_state = process_command(state, command)

        state = next_state
      end
    rescue Interrupt
      # No Op
    end
  end

  private

  def render_ui(state)
    @writer.write(@state_matrix[state][:ui].render)
  end

  def parse_input(state, input)
    @state_matrix[state][:ui].parse_input(input)
  end

  def process_command(state, command)
    (action, payload) = command

    handler = @state_matrix[state][:transitions][action]

    unless handler
      @writer.write "Invalid command!\n\n"
      return state
    end

    handler.call(payload)
  end
end
