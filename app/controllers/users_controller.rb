class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(validate_params)

        if validate_password
            byebug
            @user.save

        end

        redirect_to @user
    end

    def show
        @user = User.find(params[:id])
    end
    private
      def validate_params
          params.require(:user).permit(:name, :email, :password, :phone, :password_confirmation)
      end

      def validate_password
        @user.password == @user.password_confirmation
      end
end
