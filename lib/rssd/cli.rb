require 'rssd/server'
require 'sinatra'

module RssD
  class CLI
    def self.start(*args)
      t = Thread.new {
        while true do
          puts "[Thread] Fetching RSS..."
          Server.blogs.each do |blog, url|
            feed = Server.rss_feeds[blog]
            feed.update_feed
            feed.initialize! unless feed.initialized?
          end
          sleep 3
        end
      }
      t.abort_on_exception = true

      Server.run!
    end
  end
end
