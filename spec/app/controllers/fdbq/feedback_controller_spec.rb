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
        render_views

        let(:params) { { Fdbq.param_key => { contact_email: "some@one.com" } } }

        it 'creates feedback' do
          post :create, format: :json, params: params

          expect(response).to have_http_status(:created)

          data = JSON.parse(response.body)

          expect(data['id']).to be_present
          expect(data['created_at']).to match(/^\d{4}\-\d{2}\-\d{2}T\d{2}\:\d{2}\:\d{2}Z$/)
          expect(data['updated_at']).to match(/^\d{4}\-\d{2}\-\d{2}T\d{2}\:\d{2}\:\d{2}Z$/)
          expect(data.dig('fields', 'contact_email')).to eq("some@one.com")
        end
      end

      context 'with blank required field' do
        render_views

        let(:params) { { Fdbq.param_key => { contact_email: '' } } }

        it 'creates feedback' do
          post :create, format: :json, params: params

          expect(response).to have_http_status(:unprocessable_entity)

          data = JSON.parse(response.body)

          expect(data['id']).to be_blank
          expect(data['created_at']).to be_blank
          expect(data['updated_at']).to be_blank
          expect(data.dig('fields', 'contact_email')).to eq("")
          expect(data.dig('errors', 'fields')).to contain_exactly('is invalid')
        end
      end
    end
  end
end
