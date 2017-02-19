class PageBuilder 
	def initialize(posts)
		rss = 
		@posts = posts
	end

	def render
		@posts.each do |x|
			erb :index, :locals => {:posts => x}
		end
	end
end
