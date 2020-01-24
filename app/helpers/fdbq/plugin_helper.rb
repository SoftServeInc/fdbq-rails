module Fdbq
  module PluginHelper
    def fdbq_render
      javascript_tag "(new Fdbq(#{Fdbq.current_instance.to_json})).init();"
    end
  end
end
