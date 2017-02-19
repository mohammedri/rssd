require 'sinatra/base'
require 'tilt/erubis'
require 'rss'

module RssD
  class Server < Sinatra::Base
    configure do
      @@rss_feeds = {}
      @@blogs = {
        sirupsen: 'http://sirupsen.com/atom.xml',
        jvns: 'http://jvns.ca/atom.xml'
      }
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

    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    get '/jvns' do
      if @@rss_feeds
        @posts = @@rss_feeds[:jvns].items.map do |item|
          Post.parse_atom(item)
        end
        erb :index
      else
        "RSS not fetched"
      end
    end
  end
end
