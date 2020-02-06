module Fdbq
  class FeedbackController < Fdbq::Rails.controller_parent.constantize
    skip_before_action :verify_authenticity_token, only: :create

    def create
      @feedback = Fdbq::Feedback.new(fields: permitted_params.to_h)
      @feedback.save

      respond_to do |format|
        format.json { render(status: @feedback.persisted? ? 201 : 422) }
      end
    end

    private

    def permitted_params
      params.require(Fdbq.param_key).permit(*params[Fdbq.param_key]&.keys)
    end
  end
end
