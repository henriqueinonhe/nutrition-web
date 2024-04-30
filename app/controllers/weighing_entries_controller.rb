# frozen_string_literal: true

class WeighingEntriesController < ApplicationController
  def index
    @entries = container.get(:list_weighings).call
  end

  def create
    add_weighing = container.get(:add_weighing)

    date = Time.new(*params[:date].split("-").map(&:to_i))

    begin
      add_weighing.call(
        date:,
        weight_in_kg: params[:weight_in_kg].to_i
      )
    rescue Errors::Error => e
      flash[:error] = e.tag?(:ValidationError) ? e.msg : "An error occurred"
    end

    redirect_to weighing_entries_path
  end

  def update
    render json: "WeighingEntriesController#update"
  end

  def destroy
    delete_weighing = container.get(:delete_weighing)

    delete_weighing.call(params[:id])

    redirect_to weighing_entries_path
  end
end
