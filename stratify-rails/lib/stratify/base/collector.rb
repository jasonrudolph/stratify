require 'mongoid'
require 'stratify/base/archiver'
require 'stratify/base/field_definition'

module Stratify
  class Collector
    include Mongoid::Document

    store_in :collectors

    field :last_ran_at, :type => DateTime

    def self.configuration_fields(fields_hash = nil)
      @configuration_fields = initialize_configuration_fields(fields_hash) unless fields_hash.nil?
      @configuration_fields || []
    end

    def configuration_fields
      self.class.configuration_fields
    end

    def self.configuration_instructions(instructions = nil)
      @configuration_instructions = instructions unless instructions.nil?
      @configuration_instructions
    end

    def configuration_instructions
      self.class.configuration_instructions
    end

    def configuration_summary
      return nil if configuration_fields.empty?
      read_attribute(configuration_fields.first.name)
    end

    def run
      Archiver.new(self).run
    end

    # To be implemented by subclasses
    #
    # Returns a collection of activities to be saved.
    def activities
      raise NotImplementedError
    end

    # Define where this collector's activities originate from (e.g., "Twitter", "iTunes")
    def self.source(src = nil)
      @source = src unless src.nil?
      @source
    end

    def source
      self.class.source
    end

    def self.sources
      unsorted_sources = Collector.collector_classes.map(&:source)
      unsorted_sources.sort_by {|source| source.downcase}
    end

    class << self
      attr_reader :collector_classes
    end

    @collector_classes = []

    def self.collector_class_for(source)
      Collector.collector_classes.find {|clazz| clazz.source == source}
    end

    private

    def self.initialize_configuration_fields(fields_hash)
      field_definitions = objectify_fields(fields_hash)
      apply_fields_to_class(field_definitions)
      field_definitions
    end

    def self.objectify_fields(fields_hash)
      fields_hash.map do |f|
        name = f[0]
        attributes = f[1]
        Stratify::FieldDefinition.new(name, attributes)
      end
    end

    def self.apply_fields_to_class(field_definitions)
      field_definitions.each do |field|
        field field.name
        validates_presence_of field.name
      end
    end
  end
end
