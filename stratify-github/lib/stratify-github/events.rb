module Stratify
  module GitHub
    class Event
      extend ActionView::Helpers

      def self.trunc(text, length=140)
        truncate(text, :length => length)
      end

      class CommitCommentEvent
        def self.make(activity, api_hash)
          activity.repository = api_hash['url'].split('/')[0..4].join('/')
          activity
        end
        def self.text(activity)
          "#{activity.actor} commented on a commit to #{activity.repository}"
        end
      end

      class CreateEvent
        def self.make(activity, api_hash)
          activity.ref      = api_hash['payload']['ref']
          activity.ref_type = api_hash['payload']['ref_type']
          # This is a bummer. There's no omni-present repo element.
          if activity.ref_type == 'repository'
            activity.repository = api_hash['url']
          else
            activity.repository = api_hash['url'].split('/')[0..4].join('/')
          end
          activity
        end
        def self.text(activity)
          # ref is populated if ref_type is not 'repository'.
          ref = activity.ref ? "#{activity.ref} on" : ''
          "#{activity.actor} created #{activity.ref_type} #{ref} #{activity.repository}"
        end
      end

      class DeleteEvent
        def self.make(activity, api_hash)
          activity.ref        = api_hash['payload']['ref']
          activity.ref_type   = api_hash['payload']['ref_type']
          activity.repository = api_hash['repository']['url'] rescue nil
          activity
        end
        def self.text(activity)
          repo = activity.repository ? "from #{activity.repository}" : ""
          "#{activity.actor} deleted #{activity.ref_type} #{activity.ref} #{repo}"
        end
      end

      # Unused? Unseen in the wild.
      # class DownloadEvent
      #   def make(activity, api_hash)
      #     activity
      #   end
      #   def text(activity)
      #     "A download occurred!"
      #   end
      # end

      class FollowEvent
        def self.make(activity, api_hash)
          activity.thing = api_hash['payload']['target']['login']
          activity
        end
        def self.text(activity)
          "#{activity.actor} followed #{activity.thing}"
        end
      end

      class ForkEvent
        def self.make(activity, api_hash)
          activity.thing = api_hash['repository']['url']
          activity
        end
        def self.text(activity)
          "#{activity.actor} forked #{activity.thing}"
        end
      end

      # Unused? Unseen in the wild.
      # class ForkApplyEvent
      #   def self.make(activity, api_hash)
      #     activity.thing = api_hash['head']
      #     activity
      #   end
      #   def self.text(activity)
      #     "#{activity.actor} applied a patch in the Fork Queue to #{activity.head}"
      #   end
      # end

      class GistEvent
        def self.make(activity, api_hash)
          activity.action  = api_hash['payload']['action']
          activity.payload = api_hash['payload']['desc']
          activity
        end
        def self.text(activity)
          "#{activity.actor} #{activity.action}d a gist: #{activity.payload}"
        end
      end

      class GollumEvent
        def self.make(activity, api_hash)
          # TODO Handle more than one page per event, assuming that happens.
          activity.action     = api_hash['payload']['pages'][0]['action']
          activity.repository = api_hash['repository']['url'] rescue nil
          activity.thing      = api_hash['payload']['pages'][0]['page_name']
          activity
        end
        def self.text(activity)
          repo = activity.repository ? "on #{activity.repository}" : ""
          "#{activity.actor} #{activity.action} wiki page #{activity.thing} #{repo}"
        end
      end

      class IssueCommentEvent
        def self.make(activity, api_hash)
          activity.repository = api_hash['repository']['url']
          activity
        end
        def self.text(activity)
          "#{activity.actor} commented on an issue on #{activity.repository}"
        end
      end

      class IssuesEvent
        def self.make(activity, api_hash)
          activity.action     = api_hash['payload']['action']
          activity.repository = api_hash['url']
          activity
        end
        def self.text(activity)
          "#{activity.actor} #{activity.action} an issue on #{activity.repository}"
        end
      end

      class MemberEvent
        def self.make(activity, api_hash)
          activity.action     = api_hash['payload']['action']
          activity.repository = api_hash['url']
          activity.thing      = api_hash['payload']['member']['login']
          activity
        end
        def self.text(activity)
          "#{activity.actor} #{activity.action} #{activity.thing} as a collaborator to #{activity.repository}"
        end
      end

      class PublicEvent
        def self.make(activity, api_hash)
          activity.action     = "publicized"
          activity.repository = api_hash['repository']['url']
          activity
        end
        def self.text(activity)
          "#{activity.actor} opened #{activity.repository} to the public"
        end
      end

      class PullRequestEvent < Event
        def self.make(activity, api_hash)
          activity.payload    = api_hash['payload']['pull_request']['body'] || api_hash['payload']['pull_request']['title']
          activity.repository = api_hash['repository']['url']
          activity
        end
        def self.text(activity)
          payload = trunc(activity.payload)
          "#{activity.actor} made a pull request on #{activity.repository} -- #{payload}"
        end
      end

      class PullRequestReviewCommentEvent < Event
        def self.make(activity, api_hash)
          activity.payload    = api_hash['payload']['comment']['body']
          activity.repository = api_hash['repository']['url']
          activity
        end
        def self.text(activity)
          payload = trunc(activity.payload)
          "#{activity.actor} commented on a pull request on #{activity.repository} -- #{payload}"
        end
      end

      class PushEvent < Event
        def self.make(activity, api_hash)
          activity.action     = "pushed"
          activity.ref        = api_hash['payload']['ref']
          activity.repository = api_hash['repository']['url'] rescue nil
          activity.payload    = api_hash['payload']['shas'][0][2]
          activity
        end
        def self.text(activity)
          payload = truncate(activity.payload, :length => 140)
          "#{activity.actor} pushed to #{activity.ref} on #{activity.repository} -- #{payload}"
        end
      end

      # Unused? Unseen in the wild.
      # class TeamAddEvent
      #   def self.make(activity, api_hash)
      #     activity.ref   = api_hash['ref']
      #     activity.thing = api_hash['repository']['url']
      #     activity
      #   end
      #   def self.text(activity)
      #     "#{activity.actor} added team member #{activity.ref} to #{activity.thing}"
      #   end
      # end

      class WatchEvent
        def self.make(activity, api_hash)
          activity
        end
        def self.text(activity)
          "#{activity.actor} started watching #{activity.url}"
        end
      end

    end
  end
end
