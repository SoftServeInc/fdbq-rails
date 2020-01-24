module Fdbq
  module Rails
    module Helpers
      def fdbq_responses
        Fdbq::Feedback.all
      end
    end
  end
end
