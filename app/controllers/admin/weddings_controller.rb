class Admin::WeddingsController < ActionController::Base
  respond_to? :html

  def index
    @venues = Weddings.all
  end
end



