module Fdbq
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Fdbq


      initializer "fdbq.assets.precompile" do |app|
        app.config.assets.precompile += %w( fdbq.* )
      end
    end
  end
end
