class CollectorCoordinator
  def self.run_all
    Collector.all.each do |collector|
      begin
        collector.run
      rescue => e
        Rails.logger.error("Error running collector.  Collector => #{collector}.  Error => #{e}")
      end
    end
  end
end