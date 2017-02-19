require 'rssd/server'
require 'sinatra'

module RssD
  class CLI
    def self.start(*args)
      t = Thread.new {
        while true do
          puts "[Thread] Fetching RSS..."
          Server.blogs.each do |blog, url|
            Server.rss_feeds[blog] = RSS::Parser.parse(url, false)
          end
          sleep 300
        end
      }
      t.abort_on_exception = true
      Server.run!
    end
  end
end
