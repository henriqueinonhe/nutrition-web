# frozen_string_literal: true

class MealEntriesController < ApplicationController
  def index
    render json: {
      handler: "MealEntriesController#index",
      csrf_token: form_authenticity_token
    }
  end

  def create
    render json: "MealEntriesController#create"
  end

  def update
    render json: "MealEntriesController#update"
  end

  def destroy
    render json: "MealEntriesController#destroy"
  end
end
