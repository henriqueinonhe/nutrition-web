# frozen_string_literal: true

require "json"

class Infra::FsFoodPersistence
  def initialize(
    foods_file_path:
  )

    @foods_file_path = foods_file_path
  end

  def store(foods)
    file = File.open(@foods_file_path, "w")

    file.write(foods.map(&:to_h).to_json)

    file.close
  end

  def retrieve
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
end
