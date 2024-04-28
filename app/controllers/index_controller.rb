class IndexController < ApplicationController
  def index
    render json: { message: "Ok" }
  end
end