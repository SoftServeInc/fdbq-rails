module Fdbq
  class Feedback < Rails.model_parent.constantize
    self.table_name = "fdbq_feedback"

    serialize :fields, coder: YAML, type: Hash

    validate :required_fields

    self.instance_eval(&Fdbq::Plugin.instance.model_extensions) if Fdbq::Plugin.instance.model_extensions

    private

    def required_fields
      Fdbq.questions.select(&:required?).each do |question|
        next if question.answered?(fields.to_h)

        self.errors.add(:fields, :invalid)
      end
    end
  end
end
