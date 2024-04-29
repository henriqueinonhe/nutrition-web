# frozen_string_literal: true

module Interface::StdinReader
  def self.read
    puts
    input = readline.strip
    puts

    input
  end
end
