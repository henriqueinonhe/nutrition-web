# frozen_string_literal: true

class WeighingEntriesController < ApplicationController
  def index
    @entries = container.get(:list_weighings).call
  end

  def create
    begin
      add_weighing = container.get(:add_weighing)

      date, date_error = attempt(ArgumentError) { Time.new(*params[:date].split("-").map { |str| Integer(str) }) }

      if date_error
        flash[:error] = "Invalid date"
        redirect_to weighing_entries_path
        return
      end

      weight_in_kg, weight_error = attempt(ArgumentError) { Integer(params[:weight_in_kg]) }

      if weight_error
        flash[:error] = "Invalid weight"
        redirect_to weighing_entries_path
        return
      end

      _, add_weighing_error = attempt(Errors::Error) do
        add_weighing.call(
          date:,
          weight_in_kg:
        )
      end

      flash[:error] = compute_add_weighing_error_message(add_weighing_error) if add_weighing_error
    rescue StandardError
      flash[:error] = "Something went wrong"
    end

    redirect_to weighing_entries_path
  end

  def destroy
    delete_weighing = container.get(:delete_weighing)

    delete_weighing.call(params[:id])

    redirect_to weighing_entries_path
  end

  def compute_add_weighing_error_message(add_weighing_error)
    raise add_weighing_error unless add_weighing_error.tag?(:ValidationError)

    return "Invalid date" if add_weighing_error.sub_errors.any? { |e| e.tag?(:InvalidDate) }

    "Invalid weight" if add_weighing_error.sub_errors.any? { |e| e.tag?(:InvalidWeight) }
  end
end
