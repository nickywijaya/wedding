class Admin::UsersController < AdminController
  before_action :load_resource, only: [:confirm, :revoke, :destroy]

  respond_to? :html
  layout 'admin'

  def index
  @users = UserService.retrieve(index_attributes)
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_root_url
  end

  def confirm
    UserService.confirm(@user)

    redirect_to admin_users_path, notice: 'Sukses mengkonfirmasi user'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_users_path
  end

  def revoke
    UserService.revoke(@user)

    redirect_to admin_users_path, notice: 'Sukses menarik kembali akses admin user'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_users_path
  end

  def destroy
    UserService.delete(@user)

    redirect_to admin_users_path, notice: 'Sukses menghapus user'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_users_path
  end

  private

  def load_resource
    identifier = (params[:user_id].present?) ? params[:user_id].to_i : params[:id].to_i

    @user = User.find(identifier)
  end

  def index_attributes
    attribute = params.permit(:search, :commit).to_h

    # transform attributes
    attribute["search"] = attribute["search"].to_s.strip

    attribute
  end
end
