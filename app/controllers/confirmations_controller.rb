class ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(_resource_name, resource)
    sign_in resource unless signed_in?
    session[:pending_invitation_url] || edit_user_path(resource.id)
  end
end