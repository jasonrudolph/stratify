require 'nokogiri'

module Stratify
  module Garmin
    class RssItemAdapter
      attr_reader :item
      
      def initialize(item)
        @item = item
      end

      def activity_type
        description_content_in_table_row(4)
      end

      def created_at
        item.pubDate
      end

      def description
        description_as_nokogiri_doc.at_xpath('//table/tr[1]/td[1]').content
      end

      def distance_in_miles
        distance_string = description_content_in_table_row(6)
        distance_string.to_f
      end

      def elevation_gain_in_feet
        elevation_gain_string = description_content_in_table_row(8)
        elevation_gain_string.to_i
      end
      
      def event_type
        description_content_in_table_row(5)
      end

      def guid
        guid_url = item.guid
        guid_url.slice(/\d*$/) # parse the id out of the url ".../activity/12345678"
      end

      def starting_latitude
        starting_location[:latitude]
      end

      def starting_longitude
        starting_location[:longitude]
      end

      def time_in_seconds
        time_string = description_content_in_table_row(7)
        time_components = time_string.split(':').map(&:to_i)
        hours, minutes, seconds = time_components[0], time_components[1], time_components[2]
        (hours * 3600) + (minutes * 60) + seconds
      end

      def title
        item.title
      end

      def username
        description_content_in_table_row(2)
      end

      private

      def description_as_nokogiri_doc
        @description_doc ||= Nokogiri::HTML(item.description)
      end
      
      def description_content_in_table_row(row_index)
        description_as_nokogiri_doc.at_xpath("//table/tr[#{row_index}]/td[2]").content
      end
      
      def starting_location
        lat_long_pair_as_strings = item.georss_point.split
        lat_long_pair_as_floats = lat_long_pair_as_strings.map(&:to_f)
        {:latitude => lat_long_pair_as_floats.first, :longitude => lat_long_pair_as_floats.last}
      end
    end
  end
end
