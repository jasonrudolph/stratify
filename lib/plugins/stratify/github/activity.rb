require_dependency 'stratify/github/presenter'
require_dependency 'stratify/github/translation'

module Stratify
  module GitHub
    class Activity < Stratify::Activity
      extend Stratify::GitHub::Translation

      field :checksum
      field :url
      field :event_type
      field :repository
      field :actor
      field :action   # 'created', 'deleted', etc.
      field :ref      # The human/ref name for a branch, tag, etc.
      field :ref_type # 'branch', 'repo', 'tag'...
      field :thing    # The acted-upon item. ('target' is reserved by mongoid.)
      field :payload  # A text snippet of the comment, gists, etc.

      natural_key :checksum

      validates_presence_of :checksum, :url, :actor, :event_type

      def permalink
        url
      end

      # Let the values of this object's fields inform its checksum.
      def to_str
        fields.collect do |field, body|
          send(field) if body.type == Object
        end.compact.sort.join(' ')
      end

      def to_html
        Stratify::GitHub::Presenter.new(self).to_html
      end
    end
  end
end
