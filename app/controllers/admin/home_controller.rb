class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
   # TO-DO: next MR - implement this!

    @progress_1 = 75  # 75% for the first bar
    @progress_2 = 50  # 50% for the second bar
    @progress_3 = 25  # 25% for the third bar
    @progress_4 = 90  # 90% for the fourth bar
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_root_url # TO-DO: we need an error page for admin to avoid too many redirection error!
  end
end
