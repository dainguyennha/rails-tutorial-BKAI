class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  def broad_cast_message
#    BroadcastMessageJob.perform_later(self)
    ActionCable.server.broadcast "room_#{room_id}_channel", render_message 
  end

  private 
  def render_message 
    ApplicationController.renderer.render self
  end
end
