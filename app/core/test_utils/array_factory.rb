# frozen_string_literal: true

module TestUtils::ArrayFactory
  def self.call(factory, length)
    Array.new(length) { factory.call }
  end
end
