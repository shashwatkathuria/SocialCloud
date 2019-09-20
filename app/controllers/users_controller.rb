class UsersController < ApplicationController

    def index
        if current_user
          @user = current_user
        else
          redirect_to '/login'
        end
    end
    def new
        @user = User.new
    end

    def create
        @user = User.new(validate_params)

        if validate_password
            # byebug
            @user.save
            redirect_to @user

        else
            @failureMessage = "Invalid credentials. Please try again."
            redirect_to :action => "new", failureMessage: @failureMessage
        end

    end

    def show
        @user = User.find(params[:id])
    end

    def search
        @users = User.where("name like ?", "%" + params[:searchQuery] + "%")
        puts @users
    end

    private
      def validate_params
          params.require(:user).permit(:name, :email, :password, :phone, :password_confirmation)
      end

      def validate_password
        @user.password == @user.password_confirmation
      end

end
