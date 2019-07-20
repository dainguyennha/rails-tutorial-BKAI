class Password::ResetServices
  def initialize user
    @user = user
  end

  def call
    send_mail_reset_password_service 
  end

  private
  def send_mail_reset_password_service
    SendMailResetPasswordJob.perform_later @user, @user.password_reset_token
  end
end
