# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def container
    RootContainer
  end
end
