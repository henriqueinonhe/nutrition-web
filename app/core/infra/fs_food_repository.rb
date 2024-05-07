# frozen_string_literal: true

class Infra::FsFoodRepository
  def initialize(
    foods_file_path:
  )

    @foods_file_path = foods_file_path
  end

  def retrieve_all
    file = File.open(@foods_file_path, "r")

    serialized_foods = JSON.parse(file.read, { symbolize_names: true })

    file.close

    serialized_foods.map do |serialized_food|
      Domain::Food.new(
        id: serialized_food[:id],
        name: serialized_food[:name],
        kcal_per_gram: serialized_food[:kcal_per_gram],
        carbohydrates_in_grams_per_gram: serialized_food[:carbohydrates_in_grams_per_gram],
        protein_in_grams_per_gram: serialized_food[:protein_in_grams_per_gram],
        total_fat_in_grams_per_gram: serialized_food[:total_fat_in_grams_per_gram],
        fibers_in_grams_per_gram: serialized_food[:fibers_in_grams_per_gram],
        sodium_in_mg_per_gram: serialized_food[:sodium_in_mg_per_gram]
      )
    end
  end

  def store(foods)
    file = File.open(@foods_file_path, "w")

    file.write(foods.map(&:to_h).to_json)

    file.close
  end

  def add(
    name:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )
    foods = retrieve_all

    has_duplicate_name = foods.any? { |food| food.name == name }

    if has_duplicate_name
      raise Errors::Error.new(
        msg: "Food with name #{name} already exists!",
        tags: %i[FoodRepositoryError FailedToAdd DuplicateName]
      )
    end

    new_food = Domain::Food.new(
      id: Random.uuid,
      name:,
      kcal_per_gram:,
      carbohydrates_in_grams_per_gram:,
      protein_in_grams_per_gram:,
      total_fat_in_grams_per_gram:,
      fibers_in_grams_per_gram:,
      sodium_in_mg_per_gram:
    )

    foods << new_food

    store(foods)

    new_food
  end

  def find_by_id(id)
    foods = retrieve_all

    foods.find { |food| food.id == id }
  end

  def edit(
    id:,
    kcal_per_gram:,
    carbohydrates_in_grams_per_gram:,
    protein_in_grams_per_gram:,
    total_fat_in_grams_per_gram:,
    fibers_in_grams_per_gram:,
    sodium_in_mg_per_gram:
  )
    foods = retrieve_all

    food_to_be_edited = foods.find { |food| food.id == id }

    if food_to_be_edited.nil?
      raise Errors::Error.new(
        msg: "Food with id #{id} not found",
        tags: %i[FoodRepositoryError FailedToEdit FoodNotFound]
      )
    end

    food_to_be_edited.kcal_per_gram = kcal_per_gram
    food_to_be_edited.carbohydrates_in_grams_per_gram = carbohydrates_in_grams_per_gram
    food_to_be_edited.protein_in_grams_per_gram = protein_in_grams_per_gram
    food_to_be_edited.total_fat_in_grams_per_gram = total_fat_in_grams_per_gram
    food_to_be_edited.fibers_in_grams_per_gram = fibers_in_grams_per_gram
    food_to_be_edited.sodium_in_mg_per_gram = sodium_in_mg_per_gram

    store(foods)

    food_to_be_edited
  end

  def delete(id)
    foods = retrieve_all

    food_to_be_deleted = foods.find { |food| food.id == id }

    if food_to_be_deleted.nil?
      raise Errors::Error.new(
        msg: "Food with id #{id} not found",
        tags: %i[FoodRepositoryError FailedToDelete FoodNotFound]
      )
    end

    foods.delete(food_to_be_deleted)

    store(foods)

    nil
  end
end
