namespace :collectors do
  desc "Run all configured collectors"
  task :run => [:environment] do
    cc = CollectorCoordinator.new

    # =========================================================================
    # TWITTER
    # =========================================================================
    # To collect your tweets, add a TwitterCollector with your Twitter username
    # 
    # cc.add TwitterCollector.new("johndoe")

    # =========================================================================
    # GOWALLA
    # =========================================================================
    # To collect your Gowalla checkins, add a GowallaCollector with your 
    # Gowalla username and password.
    # 
    # cc.add GowallaCollector.new("johndoe", "password")

    # =========================================================================
    # INSTAPAPER
    # =========================================================================
    # To collect the articles that you've read on Instapaper, add an 
    # InstapaperCollector with your "RSS suffix".
    # 
    # To find your personal RSS suffix, go to the archive for your Instapaper 
    # account: http://www.instapaper.com/archive
    #
    # Look for the RSS feed link on that page.  (You should find it toward the 
    # bottom right of the page.)  The link will look something like this:
    #
    #   http://www.instapaper.com/archive/rss/123456/0123456789abcdefghijklmnopq
    # 
    # The RSS suffix is the part of the URL that comes after "/rss/".  Grab the
    # RSS suffix and use it to create an InstapaperCollector.  For example, for
    # the URL above, you would initialize the collector like so:
    # 
    # cc.add InstapaperCollector.new("123456/0123456789abcdefghijklmnopq")

    # =========================================================================
    # ITUNES
    # =========================================================================
    # To collect your iTunes activity, add an ItunesCollector with the location
    # of your "iTunes Music Library.xml" file.
    # 
    # cc.add ItunesCollector.new("/Users/johndoe/Music/iTunes/iTunes Music Library.xml")
    # 
    # cc.add ItunesCollector.new("http://dl.dropbox.com/u/1234567/iTunes%20Music%20Library.xml")

    # =========================================================================
    # RHAPSODY
    # =========================================================================
    # To collect your Rhapsody listening history, add a RhapsodyCollector with 
    # your "RSS member ID".
    #
    # To find your personal RSS member ID, go to the "My RSS Feeds" for your 
    # Rhapsody account: http://www.rhapsody.com/myrhapsody/feeds.html
    # 
    # Look for the RSS feed link labeled "Recently Played Tracks".  The link
    # should look something like this:
    # 
    #   http://feeds.rhapsody.com/member/ABCDEF0123456789ABCDEF0123456789/track-history.rss
    # 
    # The RSS member ID is the part of the URL that comes after "/member/".  Grab the
    # RSS member ID and use it to create a RhapsodyCollector.  For example, for the
    # URL above, you would initialize the collector like so:
    #
    # cc.add RhapsodyCollector.new("ABCDEF0123456789ABCDEF0123456789")

    cc.run
  end
end
