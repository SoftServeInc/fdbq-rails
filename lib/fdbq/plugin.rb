require 'yaml'
require 'singleton'

require 'fdbq/question'

module Fdbq
  class Plugin
    attr_accessor :config_file_path
    attr_accessor :param_key

    include ::Singleton

    instance.param_key = :feedback

    def questions
      config.dig('questions').to_a.map(&Question.method(:new))
    end

    def config
      YAML.load_file(config_file_path).to_h
    end
  end
end
