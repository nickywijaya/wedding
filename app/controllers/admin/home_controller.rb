class Admin::HomeController < ActionController::Base
  before_action :authenticate_user!

  respond_to? :html
  layout 'admin'

  def index
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_admins_path
  end
end
