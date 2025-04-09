class Admin::VenuesController < AdminController
  before_action :load_resource, only: [:edit, :update]

  respond_to? :html
  layout 'admin'

  def index
    @venues = Venue.all
  rescue StandardError => e
    log_error(e, action_name)
    session[:error_message] = e.message
    session[:error_backtrace] = e.backtrace.take(3)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_error_url
  end

  def edit
  rescue StandardError => e
    log_error(e, action_name, params[:id])
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_venues_path
  end

  def update
    VenueService.update(@venue, update_attributes.with_indifferent_access)

    redirect_to admin_venues_path, notice: 'Sukses mengubah data venue'
  rescue VenueService::VenueError => e
    Rails.logger.error(
      tags: ['controller', self.class.name, action_name],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        params: params,
      }
    )

    flash[:warning] = e.message
    redirect_to edit_admin_venue_path
  rescue StandardError => e
    Rails.logger.error(
      tags: ['controller', self.class.name, action_name],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        params: params,
      }
    )

    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_venues_path
  end

  private

  def load_resource
    @venue = Venue.find(params[:id])
  end

  def update_attributes
    attribute = params.required(:venue)
                .permit(:name,
                        :address,
                        :map_src,
                        :max_attendees,
                        :venue_type).to_h

    # transform attributes
    attribute[:max_attendees] = attribute[:max_attendees].to_i

    attribute
  end
end
