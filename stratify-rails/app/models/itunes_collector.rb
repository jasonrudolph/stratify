class ItunesCollector < Collector
  source "iTunes"

  configuration_fields :library_path => {:type => :string, :label => "Location of 'iTunes Music Library.xml' file"}

  configuration_instructions %q[
<p>An iTunes collector pulls in your latest iTunes activity from an "iTunes Music Library.xml" file.  On OS X, this file typically resides at <code>~/Music/iTunes/iTunes Music Library.xml</code>. To create an iTunes collector, provide the location of your iTunes XML file.</p>

<p>To pull in activity from a local iTunes library, just provide the file path, and you're all set.  For example:</p>

<p><code>/Users/johndoe/Music/iTunes/iTunes Music Library.xml</code></p>

<p>You can also pull in activity from an iTunes XML file at a remote location.  To do so, just provide a URL that points to the file.  A few examples:</p>

<p><code>http://dl.dropbox.com/u/1234567/iTunes%20Music%20Library.xml</code></p>

<p><code>ftp://username:password@LivingRoomMacMini.local/Music/iTunes/iTunes%20Music%20Library.xml</code></p>
]

  def activities
    query.activities
  end

  def query
    ItunesQuery.new(library_path)
  end
end
