# frozen_string_literal: true

class FoodsController < ApplicationController
  def index
    list_foods = container.get(:list_foods)
    @foods = list_foods.call
  end

  def show
    show_food = container.get(:show_food)
    @food = show_food.call(id: params[:id])
  end

  def new; end

  def edit
    render json: "FoodsController#edit"
  end

  def create
    add_food = container.get(:add_food)

    begin
      data = parse_create_food_params(params)
    rescue Errors::Error => e
      flash[:error] = e.msg
      redirect_to new_food_path
      return
    end

    add_food.call(
      name: data[:name],
      kcal_per_gram: data[:kcal_per_gram],
      carbohydrates_in_grams_per_gram: data[:carbohydrates_in_grams_per_gram],
      protein_in_grams_per_gram: data[:protein_in_grams_per_gram],
      total_fat_in_grams_per_gram: data[:total_fat_in_grams_per_gram],
      fibers_in_grams_per_gram: data[:fibers_in_grams_per_gram],
      sodium_in_mg_per_gram: data[:sodium_in_mg_per_gram]
    )

    redirect_to foods_path
  end

  def update
    render json: "FoodsController#update"
  end

  def destroy
    render json: "FoodsController#destroy"
  end

  private

  def parse_create_food_params(params)
    results = [
      attempt { params[:name] },
      attempt(ArgumentError) { Integer(params[:kcal_per_gram]) },
      attempt(ArgumentError) { Integer(params[:carbohydrates_in_grams_per_gram]) },
      attempt(ArgumentError) { Integer(params[:protein_in_grams_per_gram]) },
      attempt(ArgumentError) { Integer(params[:total_fat_in_grams_per_gram]) },
      attempt(ArgumentError) { Integer(params[:fibers_in_grams_per_gram]) },
      attempt(ArgumentError) { Integer(params[:sodium_in_mg_per_gram]) }
    ]

    errors = results.pluck(1)

    if errors.any?
      raise Errors::Error.new(
        msg: "Invalid parameters: #{errors.join(', ')}",
        tags: %i[ValidationError]
      )
    end

    {
      name: results[0][0],
      kcal_per_gram: results[1][0],
      carbohydrates_in_grams_per_gram: results[2][0],
      protein_in_grams_per_gram: results[3][0],
      total_fat_in_grams_per_gram: results[4][0],
      fibers_in_grams_per_gram: results[5][0],
      sodium_in_mg_per_gram: results[6][0]
    }
  end
end
