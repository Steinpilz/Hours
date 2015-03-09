class TimeSeries::LastMonthTimeSeries < TimeSeries
  def initialize(resource)
    @resource = resource
    @time_span = (Date.today.at_beginning_of_month - 1.month..Date.today.end_of_month - 1.month).freeze
  end

  def chart
    "/charts/bar_chart"
  end
end
