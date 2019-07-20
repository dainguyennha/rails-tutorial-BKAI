class SendMailResetPasswordJob < ApplicationJob
  queue_as :default

  def perform user, password_reset_token
    UserMailer.password_reset(user, password_reset_token).deliver_later
  end
end
