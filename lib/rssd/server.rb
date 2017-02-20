require 'sinatra/base'
require 'tilt/erubis'
require 'rss'
require 'rssd/feed'
require 'byebug'

module RssD
  class Server < Sinatra::Base
    configure do
      @@rss_feeds = {}
      @@blogs = {
        sirupsen: 'http://sirupsen.com/atom.xml',
        jvns: 'http://jvns.ca/atom.xml'
      }

      @@blogs.each do |blog, url|
        @@rss_feeds[blog] = RssD::Feed.new(blog, url)
      end
    end

    def self.rss_feeds
      @@rss_feeds
    end

    def self.rss_feeds=(x)
      @@rss_feeds = x
    end

    def self.blogs
      @@blogs
    end

    set :root, RssD.root_dir

    @@blogs.keys.each do |blog|
	    get "/#{blog.to_s}" do
        @posts = @@rss_feeds[blog].posts.values
        erb :index
	    end
 		end
  end
end
