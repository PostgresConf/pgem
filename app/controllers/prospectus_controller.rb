class ProspectusController < ApplicationController
  load_and_authorize_resource :conference, find_by: :short_title
    
  def show
    if @conference.sponsorship_info.try(:prospectus?)
      send_file(@conference.sponsorship_info.prospectus.path,
                filename:"prospectus_#{@conference.short_title}.#{@conference.sponsorship_info.prospectus.file.extension.downcase}")
    else
      redirect_to conference_path(@conference.short_title)
    end
  end

end
