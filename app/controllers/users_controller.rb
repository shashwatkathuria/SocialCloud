class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:search]
    def index
        if current_user
          @user = current_user
        else
          redirect_to '/login'
        end
    end
    # def new
    #     @user = User.new
    # end
    #
    # def create
    #     @user = User.new(validate_params)
    #
    #     if validate_password_and_email
    #         @user.save
    #         @successMessage = "User Successfully Created. Please Login."
    #         redirect_to controller:"sessions", action:"new", successMessage: @successMessage
    #
    #     else
    #         @failureMessage = "Invalid credentials. Please try again."
    #         redirect_to :action => "new", failureMessage: @failureMessage
    #     end
    #
    # end

    def show
        @user = User.find(params[:id])
    end

    def search
        @users = User.where("name like ?", "%" + params[:searchQuery] + "%")
    end

    # private
    #   def validate_params
    #       params.require(:user).permit(:name, :email, :password, :phone, :password_confirmation)
    #   end
    #
    #   def validate_password_and_email
    #     @user.password == @user.password_confirmation && User.where(email:@user.email).count == 0
    #   end



end
