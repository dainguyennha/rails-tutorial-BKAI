class PasswordResetsController < ApplicationController
  before_action :current_user, only: ["edit", "update"]
  before_action :auth, only: ["edit", "update"]
  before_action :check_expration, only: ["edit", "update"]

  def form_email
    @user = User.new
  end

  def create
    @user = User.find_by email: email_params[:email].downcase
    if @user && @user.save_password_reset
      @user.send_mail_user_password_reset_model
      flash[:info] = "Please check your email to reset password your account."
      redirect_to root_url
    else
      flash[:danger] = "This email is not exsit!"
      render 'form_email'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty!")
      render 'edit'
    elsif @user.update_attributes(password_params)
      log_in @user
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private
  def check_expration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired!"
      redirect_to password_resets_new_path
    end
  end

  def auth
     unless(@user && @user.authenticated?(:password_reset, params[:id]))
      render 'activation_error'
     end
  end

  def current_user
    @user = User.find_by email: params[:email]
  end

  def email_params
    params.require(:password_reset).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
