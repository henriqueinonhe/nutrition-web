# frozen_string_literal: true

class Domain::MealEntry
  attr_reader :id, :date, :weight_in_grams

  def self.validate_id(id)
    return unless !id.is_a?(String) || id.empty?

    raise Errors::Error.new(
      msg: "Id (#{id}) is not a valid id!",
      tags: %i[MealEntryValidationError InvalidId]
    )
  end

  def self.validate_date(date)
    return if date.is_a?(Time)

    raise Errors::Error.new(
      msg: "Date (#{date}) is not a valid date!",
      tags: %i[MealEntryValidationError InvalidDate]
    )
  end

  def self.validate_food(food)
    return if food.is_a?(Domain::Food)

    raise Errors::Error.new(
      msg: "Food (#{food}) is not a valid food!",
      tags: %i[MealEntryValidationError InvalidFood]
    )
  end

  def self.validate_weight_in_grams(weight_in_grams)
    return unless !weight_in_grams.is_a?(Numeric) || weight_in_grams <= 0

    raise Errors::Error.new(
      msg: "Weight (#{weight_in_grams}) is not a valid weight!",
      tags: %i[MealEntryValidationError InvalidWeightInGrams]
    )
  end

  def initialize(
    id:,
    date:,
    food:,
    weight_in_grams:
  )
    errors = [
      -> { self.class.validate_id(id) },
      -> { self.class.validate_date(date) },
      -> { self.class.validate_food(food) },
      -> { self.class.validate_weight_in_grams(weight_in_grams) }
    ].filter_map { |f| attempt(&f)[1] }

    if errors.any?
      raise Errors::Error.new(
        msg: "Meal entry construction failed!",
        tags: %i[MealEntryConstructionFailure],
        sub_errors: errors
      )
    end

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
