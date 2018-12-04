class AboutController < ApplicationController
  load_and_authorize_resource :conference, find_by: :short_title
    
  def show
    
  end


end
