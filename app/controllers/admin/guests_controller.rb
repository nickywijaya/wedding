class Admin::GuestsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update, :destroy]

  layout 'admin'

  def index
    @guests = GuestService.retrieve(index_attributes)
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  def new
    @guest = Guest.new
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  def create
    GuestService.create(create_attributes)

    redirect_to admin_guests_path, notice: 'Guest created successfully'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to new_admin_guest_path
  end

  def edit
  rescue StandardError => e
    lash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  def update
    GuestService.update(@guest, update_attributes)

    redirect_to admin_guests_path, notice: 'Guest updated successfully'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to edit_admin_guest_path
  end

  def destroy
    GuestService.delete(@guest)

    redirect_to admin_guests_path, notice: 'Guest deleted successfully'
  rescue StandardError => e
    lash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  private

  def load_resource
    @guest = Guest.find(params[:id])
  end

  def index_attributes
    attribute = params.permit(:search).to_h

    # trasnform attributes
    attribute["search"] = attribute["search"].to_s.strip

    attribute
  end

  def create_attributes
    attribute = params.required(:guest)
          .permit(:name,
                  :gender,
                  :contact,
                  :contact_source,
                  :from_groom).to_h

    # trasnform attributes
    attribute["gender"] = attribute["gender"].to_i
    attribute["contact_source"] = attribute["contact_source"].to_i
    attribute["from_groom"] = (attribute["from_groom"] == "true") ? true : false

    attribute
  end

  def update_attributes
    attribute = params.required(:guest)
          .permit(:name,
                  :gender,
                  :contact,
                  :contact_source,
                  :from_groom).to_h

    # trasnform attributes
    attribute["gender"] = attribute["gender"].to_i
    attribute["contact_source"] = attribute["contact_source"].to_i
    attribute["from_groom"] = (attribute["from_groom"] == "true") ? true : false

    attribute
  end
end
