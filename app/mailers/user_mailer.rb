class UserMailer < ApplicationMailer
  def account_activation user, activation_token
    @activation_token = activation_token
    @user =  user
    mail to: user.email, subject: "Account activation!"
  end

  def password_reset user, password_reset_token
    @password_reset_token = password_reset_token
    @user = user
    mail to: user.email, subject: "Reset password"
  end
end
