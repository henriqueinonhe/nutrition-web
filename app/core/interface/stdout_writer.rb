# frozen_string_literal: true

module Interface::StdoutWriter
  def self.write(output)
    puts output
  end

  def self.end
    Kernel.exit(0)
  end
end
