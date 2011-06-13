require 'spec_helper'

describe Stratify::ITunes::Presenter do

  context "audio track" do
    before do
      @activity = Stratify::ITunes::Activity.new(:name => "In Bloom", :artist => "Nirvana", :album => "Nevermind", 
                                                 :year => 1999, :genre => "Rock")
      @presenter = Stratify::ITunes::Presenter.new(@activity)
    end
    
    describe "summary" do
      it "provides the track name and the artist name" do
        @presenter.summary.should == "In Bloom \u2022 Nirvana"
      end

      it "provides only the track name when the artist is blank" do
        @activity.artist = ""
        @presenter.summary.should == "In Bloom"
      end

      it "provides 'Untitled' as the track name when the track name is blank" do
        @activity.name = ""
        @presenter.summary.should == "Untitled \u2022 Nirvana"
      end
    end
    
    describe "details" do
      it "provides the album, year, and genre" do
        @presenter.details.should == "Nevermind \u2022 1999 \u2022 Rock"
      end

      it "omits the year if it is nil" do
        @activity.year = nil
        @presenter.details.should == "Nevermind \u2022 Rock"
      end

      it "omits the genre if it is blank" do
        @activity.genre = ""
        @presenter.details.should == "Nevermind \u2022 1999"
      end

      it "omits the album if it is blank" do
        @activity.album = ""
        @presenter.details.should == "1999 \u2022 Rock"
      end
    end
  end
  
  context "TV show" do
    describe "episode_number" do
      it "provides the episode number if it is present" do
        activity = Stratify::ITunes::Activity.new(:tv_show => true, :episode_number => 4)
        presenter = Stratify::ITunes::Presenter.new(activity)
        presenter.episode_number.should == "Episode 4"
      end

      it "provides the track number if it is present and the episode number is nil" do
        activity = Stratify::ITunes::Activity.new(:tv_show => true, :episode_number => nil, :track_number => 4)
        presenter = Stratify::ITunes::Presenter.new(activity)
        presenter.episode_number.should == "Episode 4"
      end

      it "returns nil if both the episode number and the track number are nil" do
        activity = Stratify::ITunes::Activity.new(:tv_show => true, :episode_number => nil, :track_number => nil)
        presenter = Stratify::ITunes::Presenter.new(activity)
        presenter.episode_number.should == nil
      end
    end
    
    describe "summary" do
      before do
        @activity = Stratify::ITunes::Activity.new(:tv_show => true, :name => "Crazy Handful of Nothin", :artist => "Breaking Bad")
        @presenter = Stratify::ITunes::Presenter.new(@activity)
      end

      it "provides the episode name and the show name" do
        @presenter.summary.should == "Crazy Handful of Nothin \u2022 Breaking Bad"
      end

      it "provides only the episode name when the show name is blank" do
        @activity.artist = ""
        @presenter.summary.should == "Crazy Handful of Nothin"
      end

      it "provides 'Untitled' as the episode name when the episode name is blank" do
        @activity.name = ""
        @presenter.summary.should == "Untitled \u2022 Breaking Bad"
      end
    end
    
    describe "details" do
      before do
        @activity = Stratify::ITunes::Activity.new(:tv_show => true, :season_number => 1, :episode_number => 6, :year => 2008)
        @presenter = Stratify::ITunes::Presenter.new(@activity)
      end

      it "provides the season number, episode number, and year" do
        @presenter.details.should == "Season 1 \u2022 Episode 6 \u2022 2008"
      end

      it "omits the season number if it is nil" do
        @activity.season_number = nil
        @presenter.details.should == "Episode 6 \u2022 2008"
      end

      it "omits the episode number if it is nil" do
        @activity.episode_number = nil
        @presenter.details.should == "Season 1 \u2022 2008"
      end
      
      it "omits the year if it is nil" do
        @activity.year = nil
        @presenter.details.should == "Season 1 \u2022 Episode 6"
      end
    end    
  end

  context "movie" do
    before do
      @activity = Stratify::ITunes::Activity.new(:movie => true, :name => "V for Vendetta", :artist => "James McTeigue",
                                                 :year => 2006, :genre => "Action & Adventure")
      @presenter = Stratify::ITunes::Presenter.new(@activity)
    end
    
    describe "summary" do
      it "provides the name" do
        @presenter.summary.should == "V for Vendetta"
      end
    end
    
    describe "details" do
      it "provides the year and the genre" do
        @presenter.details.should == "2006 \u2022 Action & Adventure"
      end
      
      it "omits the year if it is nil" do
        @activity.year = nil
        @presenter.details.should == "Action & Adventure"
      end

      it "omits the genre if it is nil" do
        @activity.genre = nil
        @presenter.details.should == "2006"
      end
    end    
  end
end
