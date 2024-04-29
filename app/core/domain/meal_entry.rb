# frozen_string_literal: true

class Domain::MealEntry
  attr_reader :id, :date, :weight_in_grams

  def initialize(
    id:,
    date:,
    food:,
    weight_in_grams:
  )
    @id = id
    @date = date
    @food = food
    @weight_in_grams = weight_in_grams
  end

  def stats
    @food.stats_for_weight(weight_in_grams)
  end

  def food
    @food.clone.freeze
  end

  def to_h
    {
      id: @id,
      date: @date,
      food: @food.to_h,
      weight_in_grams: @weight_in_grams
    }
  end

  def ==(other)
    other.instance_of?(Domain::MealEntry) &&
      other.id == @id &&
      other.date.to_i == @date.to_i &&
      other.food == @food &&
      other.weight_in_grams == @weight_in_grams
  end
end
