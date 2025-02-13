class Admin::VenuesController < AdminController
  before_action :load_resource, only: [:edit, :update]

  respond_to? :html
  layout 'admin'

  def index
    @venues = Venue.all
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_venues_path
  end

  def edit
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_venues_path
  end

  def update
    VenueService.update(@venue, update_attributes.with_indifferent_access)

    redirect_to admin_venues_path, notice: 'Venue updated successfully'
  rescue VenueService::VenueError => e
    flash[:warning] = e.message
    redirect_to edit_admin_venue_path
  rescue StandardError => e
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
                        :max_attendees).to_h

    # transform attributes
    attribute[:max_attendees] = attribute[:max_attendees].to_i

    attribute
  end
end
