require 'sinatra/base'
require 'tilt/erubis'
require 'rss'

module RssD
  class Server < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    get '/jvns.ca' do
    	rss = RSS::Parser.parse('http://jvns.ca/atom.xml', false)
    	posts = rss.items.map do |item|
  			Post.parse_atom(item)
			end
      @person = "mo"
      erb :index
    end
  end
end
