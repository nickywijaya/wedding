class Admin::WeddingsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update]

  layout 'admin'

  def index
    @weddings = Weddings.all
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_weddings_path
  end

  def edit
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_weddings_path
  end

  def update
    WeddingService.update(@wedding, update_attributes)

    redirect_to admin_weddings_path, notice: 'Wedding updated successfully'
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
