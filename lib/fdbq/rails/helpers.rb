module Fdbq
  module Rails
    module Helpers
      def fdbq_responses
        Fdbq::Feedback.all
      end

      def fdbq_render
        javascript_tag "(new Fdbq(#{Fdbq.current_instance.to_json})).init();"
      end
    end
  end
end
