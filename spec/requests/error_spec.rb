require 'rails_helper'

RSpec.describe 'ErrorController', type: :request do
  describe 'GET /error' do
    it 'responds with 200 OK' do
      get '/error'

      expect(response).to have_http_status(:ok)
    end
  end
end
