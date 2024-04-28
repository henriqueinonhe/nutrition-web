# frozen_string_literal: true

class Api::WeighingEntriesController < Api::ApplicationController
  def index
    render json: "Api::WeighingEntriesController#index"
  end

  def show
    render json: "Api::WeighingEntriesController#show"
  end

  def create
    render json: "Api::WeighingEntriesController#create"
  end

  def update
    render json: "Api::WeighingEntriesController#update"
  end

  def destroy
    render json: "Api::WeighingEntriesController#destroy"
  end
end
