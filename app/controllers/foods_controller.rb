# frozen_string_literal: true

class FoodsController < ApplicationController
  def index
    render json: {
      handler: "FoodsController#index",
      csrf_token: form_authenticity_token
    }
  end

  def show
    render json: "FoodsController#show"
  end

  def new
    render json: "FoodsController#new"
  end

  def edit
    render json: "FoodsController#edit"
  end

  def create
    render json: "FoodsController#create"
  end

  def update
    render json: "FoodsController#update"
  end

  def destroy
    render json: "FoodsController#destroy"
  end
end
