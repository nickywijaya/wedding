class Admin::VenuesController < ActionController::Base
  respond_to? :html

  def index
    @venues = Venue.all
  end
end



