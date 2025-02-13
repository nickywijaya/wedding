class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_confirmation

  private

  def check_user_confirmation
    if user_signed_in? && !current_user.confirmed?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Mohon konfirmasikan akunmu terlebih dahulu, Hubungi admin untuk melakukan konfirmasi!"
    end
  end
end
