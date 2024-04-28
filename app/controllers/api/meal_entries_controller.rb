class Api::MealEntriesController < Api::ApplicationController
  def index
    render json: "Api::MealEntriesController#index"
  end

  def show
    render json: "Api::MealEntriesController#show"
  end

  def create
    render json: "Api::MealEntriesController#create"
  end

  def update
    render json: "Api::MealEntriesController#update"
  end

  def destroy
    render json: "Api::MealEntriesController#destroy"
  end
end