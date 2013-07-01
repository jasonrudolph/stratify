require 'spec_helper'

describe PunchCardGraph::TimestampGrid do
  describe "counting the timestamps that occur on a given day of the week and hour of the day" do
    it "groups timestamps occuring in the same day of the week and hour of the day" do
      timestamps = [
        Time.zone.parse("Sun, 07 Nov 2010 9:00:00 UTC"),
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 UTC")
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][9].should == 2
    end

    it "puts timestamps in different groups when they occur in different hours of the same day" do
      timestamps = [
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 UTC"),
        Time.zone.parse("Sun, 26 Jun 2011 11:00:00 UTC"),
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][9].should == 1
      grid.counts_by_day_and_hour[0][11].should == 1
    end

    it "puts timestamps in different groups when they occur in the same hour on different days" do
      timestamps = [
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 UTC"),
        Time.zone.parse("Mon, 27 Jun 2011 9:00:00 UTC")
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][9].should == 1
      grid.counts_by_day_and_hour[1][9].should == 1
    end

    it "counts every timestamp, even when there are duplicates" do
      timestamps = [
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 UTC"),
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 UTC")
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][9].should == 2
    end

    it "treats midnight as the first hour of the day" do
      timestamps = [
        Time.zone.parse("Sun, 26 Jun 2011 0:00:00 UTC"),
        Time.zone.parse("Sun, 26 Jun 2011 0:01:00 UTC")
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][0].should == 2
    end

    it "handles timestamps that were created using different timezones" do
      timestamps = [
        Time.zone.parse("Sun, 26 Jun 2011 13:00:00 GMT"),
        Time.zone.parse("Sun, 26 Jun 2011 9:00:00 EDT"),
        Time.zone.parse("Sun, 26 Jun 2011 6:00:00 PDT"),
      ]
      grid = PunchCardGraph::TimestampGrid.new(timestamps)
      grid.counts_by_day_and_hour[0][13].should == 3
    end
  end
end
