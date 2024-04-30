module WeighingEntriesHelper
  def self.format_moving_average(average)
    return "N/A" if average.nil?

    average.round(2)
  end
end
