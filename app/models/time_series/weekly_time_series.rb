class TimeSeries::WeeklyTimeSeries < TimeSeries
  def initialize(resource)
    @resource = resource
    
    @time_span = (Date.today.at_beginning_of_week..Date.today.end_of_week).freeze
  end

  def chart
    "/charts/bar_chart"
  end
end
