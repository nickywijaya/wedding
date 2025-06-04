require 'rails_helper'

RSpec.describe 'ErrorController', type: :request do

  before do
    allow_any_instance_of(ErrorController).to receive(:render)
  end

  describe 'GET /error' do
    it 'responds with 200 OK' do
      get '/error'

      expect(response).to have_http_status(:ok)
    end
  end
end
