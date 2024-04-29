# frozen_string_literal: true

require "json"

class Infra::FsWeighingEntryPersistence
  def initialize(weighings_file_path:)
    @weighings_file_path = weighings_file_path
  end

  def store(entries)
    file = File.open(@weighings_file_path, "w")

    file.write(entries.map(&:to_h).to_json)

    file.close
  end

  def retrieve
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
end
