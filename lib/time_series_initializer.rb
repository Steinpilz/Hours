module TimeSeriesInitializer
  def time_series_for(resource)
    case params[:time_span]
    when "weekly" then TimeSeries.weekly(resource)
    when "yearly" then TimeSeries.yearly(resource)
    when "last_week" then TimeSeries.last_week(resource)
    when "last_month" then TimeSeries.last_month(resource)
    else TimeSeries.monthly(resource)
    end
  end
end