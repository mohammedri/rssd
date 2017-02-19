require 'nokogiri'

module RssD
	class Post
		attr_accessor :id, :title, :link, :date, :summary

		def initialize(id, title, link, date, summary)
			@id = id
			@title = title
			@link = link
			@date = date
			@summary = summary
		end

		def self.parse_atom(item)
			id = item.id.content
			title = item.title.content
			link = item.link.href
			date = item.updated.content
			summary = get_summary(item)
			self.new(id, title, link, date, summary)
		end

		def self.get_summary(item)
			return Nokogiri::HTML(item.content.content).text[0..140] + "..."
		end
	end
end
