require 'sinatra/base'
require 'tilt/erubis'
require 'rss'
require 'rssd/feed'
require 'byebug'

module RssD
  class Server < Sinatra::Base
    configure do
      @@rss_feeds = {}
      RssD.followed.each do |blog, url|
        @@rss_feeds[blog] = RssD::Feed.new(blog, url)
      end
    end

    def self.rss_feeds
      @@rss_feeds
    end

    def self.rss_feeds=(x)
      @@rss_feeds = x
    end

    set :root, RssD.root_dir

    RssD.followed.keys.each do |blog|
	    get "/#{blog.to_s}" do
        RssD.feed_muts[blog].synchronize do
          @posts = @@rss_feeds[blog].posts.values
        end
        erb :index
	    end
 		end
  end
end
