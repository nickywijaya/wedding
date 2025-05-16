class Admin::HomeController < AdminController
  respond_to? :html
  layout 'admin'

  def index
    @wedding = Weddings.first

    @venue_holy_matrimony = @wedding.venues.holy_matrimony
    @venue_reception = @wedding.venues.reception

    # holy matrimony participant percentage
    @holy_matrimony_not_confirmed_percentage = ((@venue_holy_matrimony.fetch_not_confirmed_attendees.to_f / @venue_holy_matrimony.max_attendees.to_f) * 100).round(2)
    @holy_matrimony_attending_percentage = ((@venue_holy_matrimony.fetch_attended_attendees.to_f / @venue_holy_matrimony.max_attendees.to_f) * 100).round(2)
    @holy_matrimony_absent_percentage = ((@venue_holy_matrimony.fetch_absent_attendees.to_f / @venue_holy_matrimony.max_attendees.to_f) * 100).round(2)
    @holy_matrimony_aggregated_percentage = ((@venue_holy_matrimony.fetch_aggregated_attendees.to_f / @venue_holy_matrimony.max_attendees.to_f) * 100).round(2)

    # holy matrimony invitation percentage
    @holy_matrimony_invitation_not_sent_percentage = ((@venue_holy_matrimony.fetch_not_sent_invitation.to_f / @venue_holy_matrimony.fetch_total_invitations.to_f) * 100).round(2)
    @holy_matrimony_invitation_sent_percentage = ((@venue_holy_matrimony.fetch_sent_invitation.to_f / @venue_holy_matrimony.fetch_total_invitations.to_f) * 100).round(2)

    # reception participant percentage
    @reception_not_confirmed_percentage = ((@venue_reception.fetch_not_confirmed_attendees.to_f / @venue_reception.max_attendees.to_f) * 100).round(2)
    @reception_attending_percentage = ((@venue_reception.fetch_attended_attendees.to_f / @venue_reception.max_attendees.to_f) * 100).round(2)
    @reception_absent_percentage = ((@venue_reception.fetch_absent_attendees.to_f / @venue_reception.max_attendees.to_f) * 100).round(2)
    @reception_aggregated_percentage = ((@venue_reception.fetch_aggregated_attendees.to_f / @venue_reception.max_attendees.to_f) * 100).round(2)

    # reception invitation percentage
    @reception_invitation_not_sent_percentage = ((@venue_reception.fetch_not_sent_invitation.to_f / @venue_reception.fetch_total_invitations.to_f) * 100).round(2)
    @reception_invitation_sent_percentage = ((@venue_reception.fetch_sent_invitation.to_f / @venue_reception.fetch_total_invitations.to_f) * 100).round(2)

  rescue StandardError => e
    log_error(e, action_name)
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
