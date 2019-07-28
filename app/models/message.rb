class Message < ApplicationRecord
  belongs_to :user
  
  def broad_cast_message
    BroadcastMessageJob.perform_later(self)
   # ActionCable.server.broadcast 'room_channel', render_message 
  end

  private 
  def render_message 
    ApplicationController.renderer.render self
  end
end
