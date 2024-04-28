# frozen_string_literal: true

class IndexController < ApplicationController
  def index
    render json: { message: "Ok" }
  end
end
