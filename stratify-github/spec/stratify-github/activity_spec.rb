require 'spec_helper'
require 'digest/md5'

D = {'actor' => 'daemianmack', 'url' => 'http://example.com/'}

def DM(hsh)
  D.merge(hsh)
end

describe Stratify::GitHub::Activity do

  context 'model hygiene' do
    it 'checksums properly' do
      fields = {
        'action' => nil,
        'actor'  => 'bender',
        'url'    => 'http://example.com/',
        'type'   => 'WatchEvent'}
      checksum = Digest::MD5.hexdigest(fields.values.compact.sort.join(' '))
      activity = Stratify::GitHub::Activity.from_api_hash(fields)
      activity.checksum.should == checksum
    end
  end

  context 'translation' do
    it 'raises an error when the API passes an unknown event type' do
      fields = {'type' => 'BendGirderEvent'}
      lambda {Stratify::GitHub::Activity.from_api_hash(fields)}.should raise_error(GitHubApiError)
    end

    it 'produces correct fields for a branch CreateEvent' do
      data = DM({'type' => 'CreateEvent',
                  'url' => 'https://github.com/daemianmack/clj-cronviz/compare/new',
                  'payload' => {
                    'ref'      => 'new',
                    'ref_type' => 'branch'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'CreateEvent'
      event.ref.should == 'new'
      event.ref_type.should == 'branch'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a repo CreateEvent' do
      data = DM({'type' => 'CreateEvent',
                  'url' => 'https://github.com/daemianmack/clj-cronviz',
                  'payload' => {
                    'ref'      => nil,
                    'ref_type' => 'repository'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'CreateEvent'
      event.ref.should == nil
      event.ref_type.should == 'repository'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a CommitCommentEvent' do
      data = DM({'type' => 'CommitCommentEvent',
                  'url' => 'https://github.com/daemianmack/clj-cronviz/compare/master'})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'CommitCommentEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a DeleteEvent' do
      data = DM({'type' => 'DeleteEvent',
                  'payload' => {
                    'ref'      => 'expendable',
                    'ref_type' => 'branch'},
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'DeleteEvent'
      event.ref.should == 'expendable'
      event.ref_type.should == 'branch'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a FollowEvent' do
      data = DM({'type' => 'FollowEvent',
                  'payload' => {
                    'target' => {
                      'login' => 'defunkt'}}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'FollowEvent'
      event.thing.should == 'defunkt'
    end

    it 'produces correct fields for a ForkEvent' do
      data = DM({'type' => 'ForkEvent',
                  'repository' => {
                    'url' => 'https://github.com/jasonrudolph/stratify'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'ForkEvent'
      event.thing.should == 'https://github.com/jasonrudolph/stratify'
    end

    it 'produces correct fields for a GistEvent' do
      data = DM({'type' => 'GistEvent',
                  'payload' => {
                    'action' => 'fork',
                    'desc'   => 'using ActiveSupport::Concerns to extend Rails'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'fork'
      event.event_type.should == 'GistEvent'
      event.payload.should == 'using ActiveSupport::Concerns to extend Rails'
    end

    it 'produces correct fields for a GollumEvent' do
      data = DM({'type' => 'GollumEvent',
                  'payload' => {
                    'pages' => [{
                                  'action'    => 'created',
                                  'page_name' => 'Contributing'}]},
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'created'
      event.event_type.should == 'GollumEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
      event.thing.should == 'Contributing'
    end

    it 'produces correct fields for an IssueCommentEvent' do
      data = DM({'type' => 'IssueCommentEvent',
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'IssueCommentEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for an IssuesEvent' do
      data = DM({'type' => 'IssuesEvent',
                  'payload' => {
                    'action' => 'created'},
                  'url' => 'https://github.com/daemianmack/clj-cronviz'})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'created'
      event.event_type.should == 'IssuesEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a MemberEvent' do
      data = DM({'type' => 'MemberEvent',
                  'payload' => {
                    'action' => 'added',
                    'member' => {
                      'login' => 'bender'}},
                  'url' => 'https://github.com/daemianmack/clj-cronviz'})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'added'
      event.event_type.should == 'MemberEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
      event.thing.should == 'bender'
    end

    it 'produces correct fields for a PublicEvent' do
      data = DM({'type' => 'PublicEvent',
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'publicized'
      event.event_type.should == 'PublicEvent'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a PullRequestEvent' do
      data = DM({'type' => 'PullRequestEvent',
                  'payload' => {
                    'pull_request' => {
                      'title' => 'Allow time to flow in reverse'}},
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'PullRequestEvent'
      event.payload.should == 'Allow time to flow in reverse'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a PullRequestReviewCommentEvent' do
      data = DM({'type' => 'PullRequestReviewCommentEvent',
                  'payload' => {
                    'comment' => {
                      'body' => 'Please remove all semicolons from this JavaScript.'}},
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'PullRequestReviewCommentEvent'
      event.payload.should == 'Please remove all semicolons from this JavaScript.'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
    end

    it 'produces correct fields for a PushEvent' do
      data = DM({'type' => 'PushEvent',
                  'payload' => {
                    'ref'  => 'refs/head/master',
                    'shas' => [[nil, nil, 'Fix all the things']]},
                  'repository' => {
                    'url' => 'https://github.com/daemianmack/clj-cronviz'}})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.action.should == 'pushed'
      event.event_type.should == 'PushEvent'
      event.ref.should == 'refs/head/master'
      event.repository.should == 'https://github.com/daemianmack/clj-cronviz'
      event.payload.should == 'Fix all the things'
    end

    it 'produces correct fields for a WatchEvent' do
      data = DM({'type' => 'WatchEvent'})
      event = Stratify::GitHub::Activity.from_api_hash(data)
      event.event_type.should == 'WatchEvent'
    end
  end

end
