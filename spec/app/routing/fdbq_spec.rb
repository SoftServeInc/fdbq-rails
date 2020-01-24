require 'rails_helper'

RSpec.describe 'Fdbq routes', type: :routing do
  context 'Fdbq::FeedbackController' do
    it 'routes to create action' do
      expect(post: feedback_path).to route_to(controller: 'fdbq/feedback', action: 'create')
    end
  end
end
