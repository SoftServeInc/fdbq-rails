require 'rails_helper'

RSpec.describe Fdbq::FeedbackController, type: :controller do
  routes { Fdbq::Rails::Engine.routes }

  describe 'POST #create' do
    context 'format JSON' do
      context 'with no feedback param' do
        it 'fails with bad request' do
          expect { post(:create, format: :json) }.to raise_error(ActionController::ParameterMissing)
        end
      end

      context 'with feedback param with no blank field' do
        let(:params) { { Fdbq.param_key => { contact_email: "some@one.com" } } }

        it 'creates feedback' do
          post :create, format: :json, params: params

          expect(response).to have_http_status(:created)
        end
      end

      context 'with blank required field' do
        let(:params) { { Fdbq.param_key => { contact_email: '' } } }

        it 'creates feedback' do
          post :create, format: :json, params: params

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'with after action from ext logger' do
        let(:params) { { Fdbq.param_key => { contact_email: 'some@one.com' } } }

        it 'creates feedback' do
          expect { post(:create, format: :json, params: params) }.to change { Fdbq::Feedback.all.where(log: 'Feedback extension').count }.by(1)
        end
      end
    end
  end
end
