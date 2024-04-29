# frozen_string_literal: true

class Interface::Transitions::Exit
  def initialize(writer:)
    @writer = writer
  end

  def call(*)
    @writer.end

    :Finished
  end
end
