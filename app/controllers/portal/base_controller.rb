module Portal
  class BaseController < ApplicationController
    before_filter :verify_user

    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

    def record_not_found
      redirect_to root_path, notice: "Invalid Sponsor Name" 
    end

    def verify_user
      if (current_user.nil?)
        redirect_to sign_in_path
        return false
      end

      if (!current_user.sponsor)
        raise CanCan::AccessDenied.new('You are not authorized to access this area!')
      end
    end

    def check_user_privs
      return unless @sponsor.id != current_user.sponsor.id and !current_user.is_admin
      redirect_to portal_sponsor_path(current_user.sponsor.short_name),
                  alert: 'You are not permitted to view that page'
    end

  end
end
