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

  def log_error(e, action, track_id=0)
    Rails.logger.error(
      tags: ['controller', self.class.name, action],
      message: {
        message: e.message,
        stacktrace: e.backtrace.take(DEFAULT_BACKTRACE_LIMIT),
        track_id: track_id
      }
    )
  end
end
