# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  def container
    RootContainer
  end
end
