class ReplaceActivityCollectorNameWithSource < Mongoid::Migration
  def self.up
    say_with_time("Removing 'collector_name' attribute from all activities and replacing it with the corresponding 'source' attribute") do
      activities = Activity.all + Activity.deleted
      activities.each do |activity|
        collector_class = Class.const_get(activity.collector_name)
        activity.source = collector_class.source
        activity.collector_name = nil
        activity.save!
      end
    end
  end

  def self.down
    raise Mongoid::IrreversibleMigration, "Down migration not implemented. Implement if needed. Current status: YAGNI."
  end
end
