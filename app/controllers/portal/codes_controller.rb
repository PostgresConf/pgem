module Portal
  class CodesController < Portal::BaseController
    load_and_authorize_resource :sponsor, find_by: :short_name
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :code, through: :conference

    before_action :check_user_privs

    def show
    end
  end
end
