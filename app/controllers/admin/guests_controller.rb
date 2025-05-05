class Admin::GuestsController < AdminController
  before_action :load_resource, only: [:edit, :update, :destroy]

  respond_to? :html
  layout 'admin'

  def index
    @guests = GuestService.retrieve(index_attributes)
  rescue StandardError => e
    log_error(e, action_name)
    session[:error_message] = e.message
    session[:error_backtrace] = e.backtrace.take(3)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_error_url
  end

  def new
    @guest = Guest.new
  rescue StandardError => e
    log_error(e, action_name)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  def create
    GuestService.create(create_attributes)

    redirect_to admin_guests_path, notice: 'Sukses menambah tamu'
  rescue GuestService::GuestError => e
    Rails.logger.error(
      tags: ['controller', self.class.name, action_name],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        params: params,
      }
    )

    flash[:warning] = e.message
    redirect_to new_admin_guest_path
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
    redirect_to new_admin_guest_path
  end

  def edit
  rescue StandardError => e
    log_error(e, action_name, params[:id])
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  def update
    GuestService.update(@guest, update_attributes)

    redirect_to admin_guests_path, notice: 'Sukses mengubah data tamu'
  rescue GuestService::GuestError => e
    Rails.logger.error(
      tags: ['controller', self.class.name, action_name],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        params: params,
      }
    )

    flash[:warning] = e.message
    redirect_to edit_admin_guest_path
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
    redirect_to edit_admin_guest_path
  end

  def destroy
    GuestService.delete(@guest)

    redirect_to admin_guests_path, notice: 'Sukses menghapus tamu'
  rescue StandardError => e
    log_error(e, action_name, params[:id])
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_guests_path
  end

  private

  def load_resource
    @guest = Guest.find(params[:id])
  end

  def index_attributes
    attribute = params.permit(:search, :guest_source, :commit).to_h

    # transform attributes
    attribute["search"] = attribute["search"].to_s.strip
    attribute["guest_source"] = attribute["guest_source"].to_s.strip

    attribute
  end

  def create_attributes
    params.required(:guest)
          .permit(:name,
                  :gender,
                  :contact,
                  :contact_source,
                  :from_groom).to_h
  end

  def update_attributes
    params.required(:guest)
          .permit(:name,
                  :gender,
                  :contact,
                  :contact_source,
                  :from_groom).to_h
  end
end
