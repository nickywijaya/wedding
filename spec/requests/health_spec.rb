require 'rails_helper'

RSpec.describe 'HealthController', type: :request do
  describe 'GET /health' do
    it 'returns success message and datetime' do
      get '/healthz'

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json['message']).to eq('success')
      expect(json['datetime']).not_to be_nil
      expect(json['utc']).not_to be_nil

      expect(response.headers['Access-Control-Allow-Origin']).to eq('*')
    end
  end
end
