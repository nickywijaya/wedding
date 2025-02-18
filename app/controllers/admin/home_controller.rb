class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
    @wedding = Weddings.first

    @venue_holy_matrimony = @wedding.venues.holy_matrimony
    @venue_reception = @wedding.venues.reception
  rescue StandardError => e
    session[:error_message] = e.message
    session[:error_backtrace] = e.backtrace.take(3)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_error_url
  end

  def error
    @error_message = session[:error_message]
    @error_backtrace = session[:error_backtrace]

    # Clear the session values after using them
    session.delete(:error_message)
    session.delete(:error_backtrace)
  end
end
