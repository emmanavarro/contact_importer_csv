class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    users_index_path
  end
end
