require 'rssd/server'

module RssD
  class CLI
    def self.start(*args)
      Server.run!
    end
  end
end
