require 'rssd/server'
require 'sinatra'

module RssD
  class CLI
    def self.refresh_blogs
      RssD.followed.each do |blog, url|
        feed = Server.rss_feeds[blog]
        RssD.feed_muts[blog].synchronize do
          feed.update_feed
        end
        feed.initialize! unless feed.initialized?
      end
    end

    def self.poll_blogs(interval)
      while true do
        begin
          puts "[Thread] Fetching RSS..."
          refresh_blogs
          puts "[Thread] Sleeping..."
          sleep interval
        rescue => e
          puts e
        end
      end
    end

    def self.start(*args)
      t = Thread.new { poll_blogs(300) }
      t.abort_on_exception = true

      Server.run!
    end
  end
end
