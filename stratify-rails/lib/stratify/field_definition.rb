module Stratify
  class FieldDefinition
    attr_reader :name, :type, :label

    def initialize(name, attribute_hash)
      @name = name
      @type = attribute_hash[:type]
      @label = attribute_hash[:label]
    end

    def label
      @label || @name.to_s.titleize
    end
  end
end
