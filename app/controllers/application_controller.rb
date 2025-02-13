class ApplicationController < ActionController::Base

  # Redirect to login page after sign out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path  # This will redirect to the login page
  end

  # Redirect to logout page after sign out
  def after_sign_in_path_for(resource)
    admin_home_index_url # This will redirect to the admin dashbboard page
  end
end
