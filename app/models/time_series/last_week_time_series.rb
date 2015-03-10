class TimeSeries::LastWeekTimeSeries < TimeSeries
  def initialize(resource)
    @resource = resource
    
    @time_span = (Date.today.at_beginning_of_week - 1.week..Date.today.end_of_week - 1.week).freeze
  end

  def chart
    "/charts/bar_chart"
  end
end
