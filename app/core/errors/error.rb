# frozen_string_literal: true

class Errors::Error < StandardError
  attr_reader :msg, :tags, :sub_errors

  def initialize(msg:, tags:, sub_errors: [])
    super(msg)

    @msg = msg
    @tags = tags
    @sub_errors = sub_errors
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
