class Admin::VenuesController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update]

  def index
    @venues = Venue.all
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def edit
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def update
    VenueService.update(@venue, update_attributes.with_indifferent_access)

    redirect_to admin_venues_path, notice: 'Venue updated successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  private

  def load_resource
    @venue = Venue.find(params[:id])
  end

  def update_attributes
    params.required(:venue)
          .permit(:name,
                  :address,
                  :map_src,
                  :max_attendees).to_h
  end
end
