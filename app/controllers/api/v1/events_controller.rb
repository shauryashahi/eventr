module Api::V1
  class EventsController < ApiController

    def index
      # message, code, data = @current_user.fetch_fb_event_list(params[:rsvp_state])
      # render json: {:data => data, :message=>message}, status: code
      render json: {:data => prepare_dummy_list, :message => "Success"}, status: 200
    end

    def show
      # message, code, data = @current_user.fetch_fb_event(params[:id])
      # render json: {:data => data, :message=>message}, status: code
      render json: {:data => Constants::DUMMY_EVENT_SHOW, :message => "Success"}, status: 200
    end

    def rsvp_to_event
    end

    def events_by_location
    end

    private

      def prepare_dummy_list
        dummy_data = Hash.new
        dummy_data["data"] = Constants::DUMMY_EVENTS_LIST
        dummy_data["paging"] = Constants::PAGING
        dummy_data
      end

  end
end
