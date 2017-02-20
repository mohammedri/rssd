module RssD
  def self.root_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  def self.config
    @@config ||= YAML.load_file(root_dir + '/config.yaml')
  end

  def self.followed
    config['blogs']
  end

  def self.feed_muts
    @@muts ||= Hash.new { |hash, blog| hash[blog] = Mutex.new }
  end
end

require 'rssd/cli'
require 'rssd/post'
require 'rssd/feed'
