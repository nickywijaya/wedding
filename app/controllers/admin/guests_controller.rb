class Admin::GuestsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update, :destroy, :show]

  layout 'admin'

  def index
    @guests = Guest.all
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def new
    @guest = Guest.new
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def create
    GuestService.create(create_attributes)

    redirect_to admin_guests_path, notice: 'Guest created successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def edit
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def update
    GuestService.update(@guest, update_attributes)

    redirect_to admin_guests_path, notice: 'Guest updated successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def destroy
    GuestService.delete(@guest)

    redirect_to admin_guests_path, notice: 'Guest deleted successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  private

  def load_resource
    @guest = Guest.find(params[:id])
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
