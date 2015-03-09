class TimeSeries::LastWeekTimeSeries < TimeSeries
  def initialize(resource)
    @resource = resource
    
    begin_week = (Date.today.at_beginning_of_week - 1.week)
    end_week = begin_week + 6.days;

    @time_span = (Date.today.at_beginning_of_week - 1.week..Date.today.end_of_week - 1.week).freeze
  end

  def chart
    "/charts/bar_chart"
  end
end
