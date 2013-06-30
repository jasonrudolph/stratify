module Stratify
  module MongoidExtension
    module NaturalKey
      module ClassMethods
        attr_reader :natural_key_fields

        def natural_key(*fields)
          @natural_key_fields = fields.dup
          validates_uniqueness_of_natural_key
        end

        def validates_uniqueness_of_natural_key
          first, *rest = *natural_key_fields
          if rest.empty?
            validates_uniqueness_of first
          else
            validates_uniqueness_of first, :scope => rest
          end
        end
      end

      module InstanceMethods
        def natural_key_hash
          {}.tap do |hash|
            self.class.natural_key_fields.each do |field|
              hash[field] = self.send(field)
            end
          end
        end
      end

      def self.included(receiver)
        receiver.extend ClassMethods
        receiver.send :include, InstanceMethods
      end
    end
  end
end
