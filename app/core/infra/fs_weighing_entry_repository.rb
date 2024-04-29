# frozen_string_literal: true

class Infra::FsWeighingEntryRepository
  def initialize(
    weighings_file_path:
  )
    @weighings_file_path = weighings_file_path
  end

  def retrieve_all
    file = File.open(@weighings_file_path, "r")

    list = JSON.parse(file.read, { symbolize_names: true })

    file.close

    list.map do |serialized_entry|
      Domain::WeighingEntry.new(
        id: serialized_entry[:id],
        date: Time.new(serialized_entry[:date]),
        weight_in_kg: serialized_entry[:weight_in_kg]
      )
    end
  end

  def find_by_id(id)
    weighings = retrieve_all

    weighings.find { |weighing| weighing.id == id }
  end

  def add(
    date:,
    weight_in_kg:
  )
    new_weighing = Domain::WeighingEntry.new(
      id: Random.uuid,
      date:,
      weight_in_kg:
    )

    weighings = retrieve_all

    weighings << new_weighing

    store(weighings)
  end

  def edit(id:, date:, weight_in_kg:)
    weighings = retrieve_all

    weighing_to_be_edited = weighings.find { |weighing| weighing.id == id }

    weighing_to_be_edited.date = date
    weighing_to_be_edited.weight_in_kg = weight_in_kg

    store(weighings)
  end

  def delete(id)
    weighings = retrieve_all

    weighings.reject! { |weighing| weighing.id == id }

    store(weighings)
  end

  def store(weighings)
    file = File.open(@weighings_file_path, "w")

    file.write(weighings.map(&:to_h).to_json)

    file.close
  end
end
