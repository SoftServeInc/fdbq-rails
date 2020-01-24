require 'fdbq/plugin'

module Fdbq
  def self.param_key
    Plugin.instance.param_key
  end

  def self.questions
    Plugin.instance.questions
  end

  def self.configure(&block)
    Plugin.instance.instance_eval(&block)
  end

  def self.current_instance
    Plugin.instance.settings
  end
end
