require 'stratify-twitter/presenter'
require 'stratify-twitter/translation'

module Stratify
  module Twitter
    class Activity < Stratify::Activity
      extend Stratify::Twitter::Translation
      
      field :status_id, :type => Integer
      field :username
      field :text
      field :retweeted_status

      natural_key :status_id
  
      validates_presence_of :status_id, :username, :text

      def retweet?
        retweeted_status.present?
      end
      
      def permalink
        "http://twitter.com/#{username}/status/#{status_id}"
      end
  
      def to_html
        Stratify::Twitter::Presenter.new(self).to_html
      end
    end
  end
end
