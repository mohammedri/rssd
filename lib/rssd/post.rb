module RssD 
	class Post
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
			self.new(id, title, date, summary)
		end

		def get_summary(item)
			return Nokogiri::HTML(items[0].content.content).text[0..140] + "..."
		end

	end
end