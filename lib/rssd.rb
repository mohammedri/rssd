module RssD
  def self.root_dir
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  def self.config
    @@config ||= YAML.load_file(root_dir + '/config.yaml')
  end
end

require 'rssd/cli'
require 'rssd/post'
require 'rssd/feed'
