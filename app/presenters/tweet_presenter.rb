class TweetPresenter
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TextHelper
  
  def initialize(activity)
    @activity = activity
  end

  def text
    linkify_usernames(linkify_urls(@activity.text))
  end

  private

  def linkify_urls(text)
    auto_link(text)
  end

  def linkify_usernames(text)
    text.gsub(/@\w*\b/) do |username|
      username_without_at_sign = username.delete("@")
      username_url = "http://twitter.com/#{username_without_at_sign}"
      link_to username, username_url
    end
  end
end
