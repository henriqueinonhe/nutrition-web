# frozen_string_literal: true

RSpec.describe Interface::CommandLine do
  def setup
    writer_mock_class = Class.new do
      attr_reader :buffer

      def initialize
        @buffer = []
      end

      def write(output)
        @buffer.push(output)
      end

      def end(*)
        # NO OP
      end
    end

    reader_mock_class = Class.new do
      def initialize
        @buffer = %w[
          1
          0
          0
        ].map { |line| line }

        @index = 0
      end

      def read
        input = @buffer[@index]

        @index += 1

        input
      end
    end

    reader = reader_mock_class.new
    writer = writer_mock_class.new
    weighing_entry_persistence = Infra::FsWeighingEntryPersistence.new(
      weighings_file_path: "./storage/weighings.test.json"
    )

    container = RootContainer.derive(
      weighing_entry_persistence: Di::Container.value_resolver(weighing_entry_persistence),
      reader: Di::Container.value_resolver(reader),
      writer: Di::Container.value_resolver(writer)
    )

    {
      container:,
      writer:
    }
  end

  it "behaves as expected" do
    result = setup

    container = result[:container]
    writer = result[:writer]

    container.get(:command_line).start

    expect(writer.buffer[0]).to eq(
      <<~HEREDOC
        Nutrition Tracker

        1. Weighing Module
        0. Exit
      HEREDOC
    )

    expect(writer.buffer[1]).to eq(
      <<~HEREDOC
        Weighing Module:

        1. List weighings
        2. Add weighing
        3. Delete weighing
        0. Back
      HEREDOC
    )
  end
end
