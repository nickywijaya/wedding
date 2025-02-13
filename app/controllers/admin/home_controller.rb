class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_root_url # TO-DO: we need an error page for admin to avoid too many redirection error!
  end
end
