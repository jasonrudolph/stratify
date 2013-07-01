# Define the activity-related classes as they previously existed prior to
# extracting them into plugins.
class Activity; include Mongoid::Document; end
class GowallaCheckin < Activity; end
class InstapaperReading < Activity; end
class ItunesActivity < Activity; end
class RhapsodyListening < Activity; end
class Tweet < Activity; end

# Define the collector-related classes as they previously existed prior to
# extracting them into plugins.
class Collector; include Mongoid::Document; end
class GowallaCollector < Collector; end
class InstapaperCollector < Collector; end
class ItunesCollector < Collector; end
class RhapsodyCollector < Collector; end
class TwitterCollector < Collector; end

class UpdateTypeDataToReflectPluginExtraction < Mongoid::Migration
  def self.up
    say_with_time("Updating all existing activities to have the correct '_type' value") do
      GowallaCheckin.update_all("_type" => "Stratify::Gowalla::Activity")
      InstapaperReading.update_all("_type" => "Stratify::Instapaper::Activity")
      ItunesActivity.update_all("_type" => "Stratify::ITunes::Activity")
      RhapsodyListening.update_all("_type" => "Stratify::Rhapsody::Activity")
      Tweet.update_all("_type" => "Stratify::Twitter::Activity")
    end

    say_with_time("Updating all existing collectors to have the correct '_type' value") do
      GowallaCollector.update_all("_type" => "Stratify::Gowalla::Collector")
      InstapaperCollector.update_all("_type" => "Stratify::Instapaper::Collector")
      ItunesCollector.update_all("_type" => "Stratify::ITunes::Collector")
      RhapsodyCollector.update_all("_type" => "Stratify::Rhapsody::Collector")
      TwitterCollector.update_all("_type" => "Stratify::Twitter::Collector")
    end
  end

  def self.down
    raise Mongoid::IrreversibleMigration, "Down migration not implemented. Implement if needed. Current status: YAGNI."
  end
end
