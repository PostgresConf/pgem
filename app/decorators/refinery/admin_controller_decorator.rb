# app/decorators/refinery/admin_controller_decorator.rb

module RefineryAdminControllerAuthenticationDecorator
  protected

  def authenticate_refinery_user!
    unless current_user.try(:is_admin?)
      session["return_to"] = request.path
      redirect_to root_path and return
    end
    authenticate_user!
  end

  def current_refinery_user
    current_user
  end

  def refinery_user?
    refinery_user_signed_in? && current_refinery_user.is_admin?
  end
end

module Refinery
  module SiteBarHelper
    def display_site_bar?
        current_user && current_user.is_admin && "#{controller_name}##{action_name}" !~ %r{preview#show}
    end
  end
end

Refinery::AdminController.send :prepend, RefineryAdminControllerAuthenticationDecorator