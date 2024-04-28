class Api::FoodsController < Api::ApplicationController
  def index
    render json: "Api::FoodsController#index"
  end

  def show
    render json: "Api::FoodsController#show"
  end

  def create
    render json: "Api::FoodsController#create"
  end

  def update
    render json: "Api::FoodsController#update"
  end

  def destroy
    render json: "Api::FoodsController#destroy"
  end
end