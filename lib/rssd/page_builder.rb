class PageBuilder 
	def initialize(posts)
		@posts = posts
	end

	def render
		@posts.each do |x|
			erb :index, :locals => {:posts => x}
		end
	end
end
