class TimeSeries::MonthlyTimeSeries < TimeSeries
  def initialize(resource)
    @resource = resource
    
    @time_span = (Date.today.at_beginning_of_month..Date.today.end_of_month).freeze
  end

  def chart
    "/charts/bar_chart"
  end
end
