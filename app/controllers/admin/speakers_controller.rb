module Admin
  class SpeakersController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :program, through: :conference, singleton: true

    before_action :get_speaker, except: [:index]

    def index
      @speakers = @program.speakers.confirmed
    end

    def update
      unless speaker_params[:is_highlight].nil?
        EventUser.set_is_highlight(@program, @speaker, speaker_params[:is_highlight])
      end

      if request.xhr?
        render js: 'index'
      end
    end


    private

    def speaker_params
      params.require(:speaker).permit(:is_highlight)
    end

    def get_speaker
      @speaker = User.find(params[:id])
      unless @speaker
        redirect_to admin_conference_program_speakers_path(conference_id: @conference.short_title),
                    error: 'Error! Could not find speaker!'
        return
      end
  @event
end

  end
end
