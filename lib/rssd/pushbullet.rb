require 'net/http'
require 'json'
require 'yaml'

module RssD
	class PushBullet
		def initialize
      @access_token = RssD.config['pushbullet_access_token']
		end

		def push_note(title, body)
			json = JSON.generate({'title' => title, 'body' => body, 'type' => 'note'})
			uri = URI('https://api.pushbullet.com/v2/pushes')
			req = Net::HTTP::Post.new(uri)
			req['Access-Token'] = @access_token
			req['Content-Type'] = 'application/json'
			req.body = json


      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'

      res = http.start do |h|
        h.request req
      end

			case res
			when Net::HTTPSuccess, Net::HTTPRedirection
			  puts "Notification sent"
			else
        puts "Error sending notification: #{res.value}"
			  res.value
			end
		end
	end
end
