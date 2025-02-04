class HealthController < ApplicationController

  def index
    result = { message: 'success', datetime: Time.now.localtime, utc: Time.now.localtime.utc }

    response.headers['Access-Control-Allow-Origin'] = '*'
    render json: result.to_json
  end

end
