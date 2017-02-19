require 'sinatra/base'


module RssD
  class Server < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    get '/' do
      erb :index
    end
  end
end
