module Stratify
  class << self
    def logger
      @logger ||= initialize_logger
    end

    private
    
    def initialize_logger
      return Rails.logger if defined?(Rails)
      Logger.new(STDOUT)
    end    
  end
end
