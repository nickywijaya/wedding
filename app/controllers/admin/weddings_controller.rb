class Admin::WeddingsController < AdminController
  before_action :load_resource, only: [:edit, :update]

  respond_to? :html
  layout 'admin'

  def index
    @weddings = Weddings.all
  rescue StandardError => e
    session[:error_message] = e.message
    session[:error_backtrace] = e.backtrace.take(3)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_error_url
  end

  def edit
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_weddings_path
  end

  def update
    WeddingService.update(@wedding, update_attributes)

    redirect_to admin_weddings_path, notice: 'Sukses mengubah data perkawinan'
  rescue WeddingService::WeddingError => e
    flash[:warning] = e.message
    redirect_to edit_admin_wedding_path
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to edit_admin_wedding_path
  end

  private

  def load_resource
    @wedding = Weddings.find(params[:id])
  end

  def update_attributes
    params.required(:weddings)
          .permit(:hashtag,
                  :story).to_h
  end
end
