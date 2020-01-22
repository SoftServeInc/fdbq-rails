module Fdbq
  class Question
    attr_accessor :label, :name, :value, :placeholder, :type, :required, :hint

    def initialize(attrs = {})
      attrs.to_h.each_pair do |k, v|
        self.send("#{k}=", v)
      end
    end

    def param_key
      name.to_s
    end

    def answered?(answers)
      answers.to_h.stringify_keys[param_key].present?
    end

    def required?
      !!required
    end
  end
end
