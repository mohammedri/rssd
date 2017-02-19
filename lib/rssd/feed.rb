require 'rssd/pushbullet'

module RssD
  class Feed
    def initialize(id, url)
      @id = id
      @url = url
      @posts = {}
      @pushbullet = PushBullet.new
    end

    def posts
      @posts
    end

    def notify(p)
      @pushbullet.push_note(p.title, p.link)
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
