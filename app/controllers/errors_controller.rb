class ErrorsController < ApplicationController
  skip_authorization_check
  def not_found
    render(status: 404, layout: 'errors')
  end

  def internal_server_error
    render(status: 500, layout: 'errors')
  end
end