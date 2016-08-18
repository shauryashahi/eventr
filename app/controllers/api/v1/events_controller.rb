module Api::V1
  class EventsController < ApiController

    def index
      message, code, data = @current_user.fetch_fb_event_list(params[:rsvp_state])
      render json: {:data => data, :message=>message}, status: code
    end

    def show
      message, code, data = @current_user.fetch_fb_event(params[:id])
      render json: {:data => data, :message=>message}, status: code
    end

    def rsvp_to_event
    end

    def events_by_location
    end

  end
end
