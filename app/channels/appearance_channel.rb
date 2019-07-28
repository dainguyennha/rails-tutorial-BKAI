class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    current_user.appear
    stream_from "appearance_channel"
  end

  def unsubscribed
    current_user.disappear
  end
end
