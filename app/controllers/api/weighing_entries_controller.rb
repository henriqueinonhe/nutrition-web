# frozen_string_literal: true

class Api::WeighingEntriesController < Api::ApplicationController
  def index
    list_weighings = container.get(:list_weighings)

    entries = list_weighings.call

    formatted_entries = entries.map do |weighing, average|
      {
        weighing:,
        average:
      }
    end

    render json: formatted_entries
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
