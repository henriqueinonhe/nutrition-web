class WeighingEntriesController < ApplicationController
  def index
    render json: {
      handler: 'WeighingEntriesController#index',
      csrf_token: form_authenticity_token
    }
  end

  def create
    render json: 'WeighingEntriesController#create'
  end

  def update
    render json: 'WeighingEntriesController#update'
  end

  def destroy
    render json: 'WeighingEntriesController#delete'
  end
end