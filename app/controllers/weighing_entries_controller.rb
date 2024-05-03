# frozen_string_literal: true

class WeighingEntriesController < ApplicationController
  def index
    @entries = container.get(:list_weighings).call
  end

  def create
    add_weighing = container.get(:add_weighing)

    begin
      date = Time.new(*params[:date].split("-").map { |str| Integer(str) })
      # TODO: We want more robust validation
    rescue ArgumentError
      flash[:error] = "Invalid date"
    end

    begin
      add_weighing.call(
        date:,
        weight_in_kg: Integer(params[:weight_in_kg])
      )
    rescue Errors::Error => e
      flash[:error] = e.tag?(:ValidationError) ? e.msg : "An error occurred"
    rescue ArgumentError
      flash[:error] = "Invalid weight"
    end

    redirect_to weighing_entries_path
  end

  def destroy
    delete_weighing = container.get(:delete_weighing)

    delete_weighing.call(params[:id])

    redirect_to weighing_entries_path
  end

  private

  # def
  # end
end
