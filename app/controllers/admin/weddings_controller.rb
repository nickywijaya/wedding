class Admin::WeddingsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update]

  def index
    @weddings = Weddings.all
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def edit
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def update
    WeddingService.update(@wedding, update_attributes)

    redirect_to admin_weddings_path, notice: 'Wedding updated successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
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
