require 'twitter'

module Stratify
  module Twitter
    class Collector < Stratify::Collector
      source "Twitter"

      configuration_fields :consumer_key => {:type => :string},
                           :consumer_secret => {:type => :string},
                           :oauth_token => {:type => :string, :label => "OAuth Token"},
                           :oauth_token_secret => {:type => :string, :label => "OAuth Token Secret"},
                           :username => {:type => :string}

      configuration_instructions %q[
        <p>
          To collect your tweets, you first need to obtain some credentials from Twitter.
          You get those credentials by registering an application (i.e., <strong>your</strong> instance of Stratify) with Twitter.
        </p>

        <p>
          To register your app, head over to <a href="https://dev.twitter.com/apps/new" target="_blank">dev.twitter.com/apps/new</a>.
          You'll be asked for some information about your app.
          <a href="/assets/app-registration-screenshot.png" target="_blank">These values</a> will get the job done.
        </p>

        <p>
          After you register your app, you should see a button for <a href="https://dev.twitter.com/docs/auth/tokens-devtwittercom" target="_blank">creating an access token</a>.
          Once you've got your access token, you're ready to set up your collector below.
        </p>

        <p>
          Fill in the credentials that you got from dev.twitter.com.
          Then, fill in your <strong>username</strong> to start collecting your tweets.
        </p>
      ]

      def configuration_summary
        username
      end

      def activities
        activities_from_api.map do |activity_in_api_format|
          Stratify::Twitter::Activity.from_api_hash(activity_in_api_format)
        end
      end

      private

      def activities_from_api
        client.user_timeline(username, :include_rts => true, :count => 50)
      end

      def client
        ::Twitter::Client.new(
          :consumer_key => consumer_key,
          :consumer_secret => consumer_secret,
          :oauth_token => oauth_token,
          :oauth_token_secret => oauth_token_secret
        )
      end
    end
  end
end

Stratify::Collector.collector_classes << Stratify::Twitter::Collector
