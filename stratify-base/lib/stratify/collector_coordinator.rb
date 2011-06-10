module Stratify
  class CollectorCoordinator
    def self.run_all
      Stratify::Collector.all.each do |collector|
        begin
          collector.run
        rescue => e
          Stratify.logger.error("Error running collector.  Collector => #{collector}.  Error => #{e}")
        end
      end
    end
  end
end