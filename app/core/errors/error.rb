# frozen_string_literal: true

class Errors::Error < StandardError
  attr_reader :msg, :tags

  def initialize(msg:, tags:)
    super(msg)

    @msg = msg
    @tags = tags
  end

  def tag?(*tags)
    tags.any? { |tag| @tags.include?(tag) }
  end

  def to_s
    <<~HEREDOC
      #{super()}

      Tags: #{@tags}
    HEREDOC
  end
end
