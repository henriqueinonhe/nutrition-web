# frozen_string_literal: true

class Domain::Food
  attr_reader :id,
              :name,
              :kcal_per_gram,
              :carbohydrates_in_grams_per_gram,
              :protein_in_grams_per_gram,
              :total_fat_in_grams_per_gram,
              :fibers_in_grams_per_gram,
              :sodium_in_mg_per_gram

  def self.validate_id(id)
    return if id.is_a?(String) && !id.empty?

    raise Errors::Error.new(
      msg: "ID (#{id}) is not a valid ID!",
      tags: %i[FoodValidationError InvalidId]
    )
  end

  def self.validate_name(name)
    return if name.is_a?(String) && !name.empty?

    raise Errors::Error.new(
      msg: "Name (#{name}) is not a valid name!",
      tags: %i[FoodValidationError InvalidName]
    )
  end

  def self.validate_kcal_per_gram(kcal_per_gram)
    return if quantity_per_gram_is_valid?(kcal_per_gram)

    raise Errors::Error.new(
      msg: "Kcal per gram (#{kcal_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidKcalPerGram]
    )
  end

  def self.validate_carbohydrates_in_grams_per_gram(carbohydrates_in_grams_per_gram)
    return if quantity_per_gram_is_valid?(carbohydrates_in_grams_per_gram)

    raise Errors::Error.new(
      msg: "Carbohydrates in grams per gram (#{carbohydrates_in_grams_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidCarbohydratesInGramsPerGram]
    )
  end

  def self.validate_protein_in_grams_per_gram(protein_in_grams_per_gram)
    return if quantity_per_gram_is_valid?(protein_in_grams_per_gram)

    raise Errors::Error.new(
      msg: "Protein in grams per gram (#{protein_in_grams_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidProteinInGramsPerGram]
    )
  end

  def self.validate_total_fat_in_grams_per_gram(total_fat_in_grams_per_gram)
    return if quantity_per_gram_is_valid?(total_fat_in_grams_per_gram)

    raise Errors::Error.new(
      msg: "Total fat in grams per gram (#{total_fat_in_grams_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidTotalFatInGramsPerGram]
    )
  end

  def self.validate_fibers_in_grams_per_gram(fibers_in_grams_per_gram)
    return if quantity_per_gram_is_valid?(fibers_in_grams_per_gram)

    raise Errors::Error.new(
      msg: "Fibers in grams per gram (#{fibers_in_grams_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidFibersInGramsPerGram]
    )
  end

  def self.validate_sodium_in_mg_per_gram(sodium_in_mg_per_gram)
    return if quantity_per_gram_is_valid?(sodium_in_mg_per_gram)

    raise Errors::Error.new(
      msg: "Sodium in mg per gram (#{sodium_in_mg_per_gram}) is not a valid quantity per gram!",
      tags: %i[FoodValidationError InvalidSodiumInMgPerGram]
    )
  end

  def initialize(
    id:,
    name:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )

    errors = [
      -> { self.class.validate_id(id) },
      -> { self.class.validate_name(name) },
      -> { self.class.validate_kcal_per_gram(kcal_per_gram) },
      -> { self.class.validate_carbohydrates_in_grams_per_gram(carbohydrates_in_grams_per_gram) },
      -> { self.class.validate_protein_in_grams_per_gram(protein_in_grams_per_gram) },
      -> { self.class.validate_total_fat_in_grams_per_gram(total_fat_in_grams_per_gram) },
      -> { self.class.validate_fibers_in_grams_per_gram(fibers_in_grams_per_gram) },
      -> { self.class.validate_sodium_in_mg_per_gram(sodium_in_mg_per_gram) }
    ].filter_map { |f| attempt(&f)[1] }

    if errors.any?
      raise Errors::Error.new(
        msg: "Food construction failed!",
        tags: %i[FoodConstructionFailure],
        sub_errors: errors
      )
    end

    @id = id
    @name = name
    @kcal_per_gram = kcal_per_gram
    @carbohydrates_in_grams_per_gram = carbohydrates_in_grams_per_gram
    @protein_in_grams_per_gram = protein_in_grams_per_gram
    @total_fat_in_grams_per_gram = total_fat_in_grams_per_gram
    @fibers_in_grams_per_gram = fibers_in_grams_per_gram
    @sodium_in_mg_per_gram = sodium_in_mg_per_gram
  end

  def kcal_per_gram=(kcal_per_gram)
    self.class.validate_kcal_per_gram(kcal_per_gram)

    @kcal_per_gram = kcal_per_gram
  end

  def carbohydrates_in_grams_per_gram=(carbohydrates_in_grams_per_gram)
    self.class.validate_carbohydrates_in_grams_per_gram(carbohydrates_in_grams_per_gram)

    @carbohydrates_in_grams_per_gram = carbohydrates_in_grams_per_gram
  end

  def protein_in_grams_per_gram=(protein_in_grams_per_gram)
    self.class.validate_protein_in_grams_per_gram(protein_in_grams_per_gram)

    @protein_in_grams_per_gram = protein_in_grams_per_gram
  end

  def total_fat_in_grams_per_gram=(total_fat_in_grams_per_gram)
    self.class.validate_total_fat_in_grams_per_gram(total_fat_in_grams_per_gram)

    @total_fat_in_grams_per_gram = total_fat_in_grams_per_gram
  end

  def fibers_in_grams_per_gram=(fibers_in_grams_per_gram)
    self.class.validate_fibers_in_grams_per_gram(fibers_in_grams_per_gram)

    @fibers_in_grams_per_gram = fibers_in_grams_per_gram
  end

  def sodium_in_mg_per_gram=(sodium_in_mg_per_gram)
    self.class.validate_sodium_in_mg_per_gram(sodium_in_mg_per_gram)

    @sodium_in_mg_per_gram = sodium_in_mg_per_gram
  end

  def stats_for_weight(weight_in_grams)
    # NOTE: Maybe extract this to a value object
    {
      kcal: kcal_per_gram * weight_in_grams,
      carbohydrates_in_grams: carbohydrates_in_grams_per_gram * weight_in_grams,
      protein_in_grams: protein_in_grams_per_gram * weight_in_grams,
      total_fat_in_grams: total_fat_in_grams_per_gram * weight_in_grams,
      fibers_in_grams: fibers_in_grams_per_gram * weight_in_grams,
      sodium_in_mg: sodium_in_mg_per_gram * weight_in_grams
    }
  end

  def to_h
    {
      id: @id,
      name: @name,
      kcal_per_gram: @kcal_per_gram,
      carbohydrates_in_grams_per_gram: @carbohydrates_in_grams_per_gram,
      protein_in_grams_per_gram: @protein_in_grams_per_gram,
      total_fat_in_grams_per_gram: @total_fat_in_grams_per_gram,
      fibers_in_grams_per_gram: @fibers_in_grams_per_gram,
      sodium_in_mg_per_gram: @sodium_in_mg_per_gram
    }
  end

  def ==(other)
    other.instance_of?(Domain::Food) &&
      other.id == @id &&
      other.name == @name &&
      other.kcal_per_gram == @kcal_per_gram &&
      other.carbohydrates_in_grams_per_gram == @carbohydrates_in_grams_per_gram &&
      other.protein_in_grams_per_gram == @protein_in_grams_per_gram &&
      other.total_fat_in_grams_per_gram == @total_fat_in_grams_per_gram &&
      other.fibers_in_grams_per_gram == @fibers_in_grams_per_gram &&
      other.sodium_in_mg_per_gram == @sodium_in_mg_per_gram
  end

  def clone
    Domain::Food.new(
      id: @id,
      name: @name,
      kcal_per_gram: @kcal_per_gram,
      carbohydrates_in_grams_per_gram: @carbohydrates_in_grams_per_gram,
      protein_in_grams_per_gram: @protein_in_grams_per_gram,
      total_fat_in_grams_per_gram: @total_fat_in_grams_per_gram,
      fibers_in_grams_per_gram: @fibers_in_grams_per_gram,
      sodium_in_mg_per_gram: @sodium_in_mg_per_gram
    )
  end

  def self.quantity_per_gram_is_valid?(value)
    value.is_a?(Numeric) && value >= 0
  end
end
