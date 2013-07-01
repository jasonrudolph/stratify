require 'mongoid'

require_dependency 'stratify/mongoid_extension'
require_dependency 'stratify/renderable'

module Stratify
  class Activity
    include Mongoid::Document
    include Mongoid::Paranoia
    include MongoidExtension::NaturalKey
    include Renderable

    store_in :activities

    field :source, :type => String
    field :created_at, :type => DateTime

    validates_presence_of :created_at

    def permalink
      nil
    end

    def created_on
      return nil unless created_at
      created_at.to_date
    end

    def duplicate?
      duplicate_activities = self.class.where(natural_key_hash)
      duplicate_activities.exists? || duplicate_activities.deleted.exists?
    end
  end
end
