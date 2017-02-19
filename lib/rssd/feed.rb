module RssD
  class Feed
    def initialize(id, url)
      @id = id
      @url = url
      @posts = {}
    end

    def posts
      @posts
    end

    def notify(p)
      puts "Found new post #{p.id}"
    end

    def update_feed
      rss = RSS::Parser.parse(@url, false)
      rss.items.each do |item|
        p = Post.parse_atom(item)
        if @posts[p.id].nil?
          notify(p)
        end

        @posts[p.id] = p
      end
    end
  end
end
