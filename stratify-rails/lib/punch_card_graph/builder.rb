# Builds the URL needed to render a "punch card" graph using the Google
# Charts API.
#
# API docs:
#
#   http://code.google.com/apis/chart/image/docs/gallery/scatter_charts.html
#
module PunchCardGraph
  class Builder
    attr_accessor :timestamps

    def initialize(options={})
      @timestamps = options[:timestamps]
    end

    def base_url
      'https://chart.googleapis.com/chart'
    end

    def background_fills
      'chf=bg,s,f7f7f7'
    end

    def chart_size
      'chs=800x300'
    end

    def chart_type
      'cht=s'
    end

    def custom_axis_labels
      x_axis_label = '0:||12am|1|2|3|4|5|6|7|8|9|10|11|12pm|1|2|3|4|5|6|7|8|9|10|11||'
      y_axis_label = '1:||Sun|Mon|Tue|Wed|Thr|Fri|Sat|'
      'chxl=' + x_axis_label + y_axis_label
    end

    # Returns string with the format:
    #
    #   chd=t:<x_values>|<y_values>|<point_size_values>
    def data_series
      values = [x_values, y_values, point_size_values].join('|')
      'chd=t:' + values
    end

    def data_series_min_and_max_values
      values = [-1, 24, -1, 7, min_point_size, max_point_size].join(',')
      'chds=' + values
    end

    def range_markers
      'chm=o,333333,1,1.0,25.0'
    end

    def visible_axes
      'chxt=x,y'
    end

    def to_url
      query_string = [
        chart_type,
        chart_size,
        background_fills,
        range_markers,
        visible_axes,
        custom_axis_labels,
        data_series_min_and_max_values,
        data_series,
      ].join('&')

      base_url + '?' + query_string
    end

    private

    def x_values
      "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"
    end

    def y_values
      "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6"
    end

    def point_size_values
      point_size_array.join(',')
    end

    def min_point_size
      point_size_array.min
    end

    def max_point_size
      point_size_array.max
    end

    def point_size_array
      grid = TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour.flatten
    end
  end
end
