module Fdbq
  class FeedbackController < Fdbq::Rails.controller_parent.constantize
    skip_before_action :verify_authenticity_token, only: :create

    self.instance_eval(&Fdbq::Plugin.instance.controller_extensions) if Fdbq::Plugin.instance.controller_extensions

    def create
      @feedback = Fdbq::Feedback.new(fields: permitted_params.to_h)
      
      if @feedback.save
        flash.now[:notice] = I18n.t('fdbq.events.created')
      end

      respond_to do |format|
        format.json { head(@feedback.persisted? ? 201 : 422) }
      end
    end

    private

    def permitted_params
      params.require(Fdbq.param_key).permit(*params[Fdbq.param_key]&.keys)
    end
  end
end
