# frozen_string_literal: true

module Errors::ReturnError
  def self.call
    yield
  rescue Exception => e # rubocop:disable Lint/RescueException
    e
  end
end
