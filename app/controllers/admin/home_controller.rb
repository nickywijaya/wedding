class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_admins_path
  end
end
