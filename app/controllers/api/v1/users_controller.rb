module Api::V1
  class UsersController < ApiController
    before_action :set_user, only: [:show]

    # GET /users/1
    def show
      render json: @user
    end

    private
      def set_user
        @user = User.find(params[:id])
      end
  end
end
