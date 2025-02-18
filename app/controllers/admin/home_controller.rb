class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
    @wedding = Weddings.first

    @venue_holy_matrimony = @wedding.venues.holy_matrimony
    @venue_reception = @wedding.venues.reception
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to 'google.com' # TO-DO: we need an error page for admin to avoid too many redirection error!
  end

  def error
    # TO-DO: create error page!
  end
end
