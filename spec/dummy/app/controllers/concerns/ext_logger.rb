module ExtLogger
  extend ActiveSupport::Concern

  included do
    after_action :extend_feedback

    private

    def extend_feedback
      return if @feedback.new_record?

      @feedback.update(log: 'Feedback extension')
    end
  end
end
