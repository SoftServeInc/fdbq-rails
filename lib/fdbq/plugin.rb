require 'yaml'
require 'singleton'

require 'fdbq/question'

module Fdbq
  class Plugin
    DEFAULT_PARAM_KEY = :feedback

    attr_accessor :config_file_path
    attr_accessor :param_key

    include ::Singleton

    instance.param_key = DEFAULT_PARAM_KEY

    def reset!
      self.param_key = DEFAULT_PARAM_KEY
      self.config_file_path = nil
    end

    def questions
      config.dig('questions').to_a.map(&Question.method(:new))
    end

    def settings
      config.tap do |c|
        c['questions']&.map! { |el| el.merge('name' => build_param_key(el['name'])) }

        c['submit'] = { url: Rails::Engine.routes.url_helpers.feedback_path }
      end
    end

    def config
      YAML.load_file(config_file_path).to_h
    end

    def build_param_key(question_name)
      "#{param_key}[#{question_name}]"
    end
  end
end
