module TweetHelper
  def auto_link_tweet_text(text)
    auto_link_tweet_text_usernames(auto_link_tweet_text_urls(text))
  end

  def auto_link_tweet_text_usernames(text)
    text.gsub(/@\w*\b/) do |username|
      username_without_at_sign = username.delete("@")
      username_url = "http://twitter.com/#{username_without_at_sign}"
      link_to username, username_url
    end
  end
  
  def auto_link_tweet_text_urls(text)
    auto_link(text)
  end
end
