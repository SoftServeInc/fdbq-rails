module ExtensionTestable
  extend ActiveSupport::Concern

  included do
    validate :controller_log_if_present

    private

    def controller_log_if_present
      return if log.blank? || log.eql?('Feedback extension')

      self.errors.add(:base, :invalid)
    end
  end
end
