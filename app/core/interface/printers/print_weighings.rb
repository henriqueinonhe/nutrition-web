# frozen_string_literal: true

class Interface::Printers::PrintWeighings
  def initialize(writer:)
    @writer = writer
  end

  def call(entries)
    # TEMP
    index = 0

    entries.each do |(weighing, average)|
      position = index + 1
      formatted_date = weighing.date.strftime("%d/%m/%Y")
      formatted_weight = "#{weighing.weight_in_kg}Kg"
      formatted_average = format_average(average)

      @writer.write "#{position}. #{formatted_date} #{formatted_weight} #{formatted_average}"

      index += 1
    end

    @writer.write("\n")
  end

  private

  def format_average(average)
    return "#{average}Kg" if average

    "N/A"
  end
end
