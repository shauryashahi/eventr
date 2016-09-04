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
      message, code, data = @current_user.rsvp_event(params[:fb_event_id], params[:rsvp_state])
      render json: {:message => message, :data => data}, status: code
    end

    def events_by_location
      render json: {:data => Constants::DUMMY_NEARBY_EVENTS, :message => "Success"}, status: 200
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
