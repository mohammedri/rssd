require 'net/http'
require 'json'

module RssD
	class PushBullet
		def initialize
			@access_token = ENV['PUSHBULLET_ACCESS_TOKEN']
		end

		def push_note(title, body)
			json = JSON.generate({'title' => title, 'body' => body})
			uri = URI('https://api.pushbullet.com/v2/pushes')
			req = Net::HTTP::Post.new(uri)
			req['Access-Token'] = @access_token 
			req['Content-Type'] = 'application/json'
			req.body = json


			res = Net::HTTP.start(uri.hostname, uri.port) do |http|
			  http.request(req)
			end

			case res
			when Net::HTTPSuccess, Net::HTTPRedirection
			  puts "Notification sent"
			else
				puts "Error sending notification"
			  res.value
			end
		end
	end
end
