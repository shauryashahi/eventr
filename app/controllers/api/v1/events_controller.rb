module Api::V1
  class EventsController < ApiController
    before_action :set_event, only: [:show]

    def index
      events = @current_user.fetch_fb_event_list(params[:rsvp_state])
      unless events.blank?
        render json: {:data => events, :message=>"Event List Fetched."}, status: 200
      else
        render json: {:data => {}, :message=>"Oops, Something Went Wrong. Try Again after a while."}, status: 400
      end
    end

    def show
      render json: {:data => @event, :message=>"Success"}, status: 200
    end

    def rsvp
    end

    private
      def set_event
        @event = @current_user.fetch_fb_event(params[:id])
        if @event.blank?
          render json: {:data => {}, :message=>"Oops, Something Went Wrong. Try Again after a while."}, stauts: 400 and return
        end
      end
  end
end
