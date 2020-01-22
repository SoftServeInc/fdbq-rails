module Fdbq
  class Feedback < Rails.model_parent.constantize
    self.table_name = "fdbq_feedback"

    serialize :fields, Hash


    validate :required_fields

    private

    def required_fields
      Fdbq.questions.select(&:required?).each do |question|
        next if question.answered?(fields.to_h)

        self.errors.add(:fields, :invalid)
      end
    end
  end
end
