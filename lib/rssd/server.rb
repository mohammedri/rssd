require 'sinatra/base'
require 'tilt/erubis'

module RssD
  class Server < Sinatra::Base
    set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    get '/jvns.ca' do
      @person = "mo"
      erb :index
    end
  end
end
