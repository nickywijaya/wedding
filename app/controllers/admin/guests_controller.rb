class Admin::GuestsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update, :destroy, :show]

  layout 'admin'

  def index
    @guests = Guest.all
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def edit
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def update
    # TO-DO: implement GuestService.update(@guest, update_attributes)
    #GuestService.update(@guests, update_attributes)

    redirect_to admin_guests_path, notice: 'Guest updated successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def new
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def create
    # TO-DO: implement GuestService.create(@guest, update_attributes)
    #GuestService.create(create_attributes)

    redirect_to admin_guests_path, notice: 'Guest created successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def destroy
    # TO-DO: implement GuestService.delete(@guest, update_attributes)
    #GuestService.delete(@guest)

    binding.pry

    redirect_to admin_guests_path, notice: 'Guest deleted successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  private

  def load_resource
    @guest = Guest.find(params[:id])
  end

  def create_attributes
    params.required(:guest)
          .permit(:name,
                  :gender).to_h
  end

  def update_attributes
    params.required(:guest)
          .permit(:name,
                  :gender).to_h
  end
end
