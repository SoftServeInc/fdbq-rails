module Fdbq
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Fdbq
      engine_name 'fdbq'

      initializer "fdbq.assets.precompile" do |app|
        app.config.assets.precompile += %w( fdbq.* )
      end

      initializer "fdbq.engine" do |app|
        ActionController::Base.send :include, Fdbq::Rails::Helpers
        ActionView::Base.send :include, Fdbq::Rails::Helpers
      end
    end
  end
end
