require 'sinatra'

set :root, "/Users/mohammedislam/rssd"

get '/jvns.ca' do
	erb :index
end


