# frozen_string_literal: true

module Domain::ComputeWeighingAverages
  MOVING_AVERAGE_WINDOW_SIZE_IN_DAYS = 5

  def self.call(weighings)
    averages = []

    weights = weighings.map(&:weight_in_kg)

    weights.each_index do |index|
      if index + 1 < MOVING_AVERAGE_WINDOW_SIZE_IN_DAYS
        averages.push(nil)
        next
      end

      average = weights[index + 1 - MOVING_AVERAGE_WINDOW_SIZE_IN_DAYS..index].sum / MOVING_AVERAGE_WINDOW_SIZE_IN_DAYS
      averages.push(average)
    end

    averages
  end
end
