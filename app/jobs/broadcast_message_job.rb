class BroadcastMessageJob < ApplicationJob
  queue_as :default

  def perform message
#    room = Room.find_by id: room_id
#    room.users.each do |user|
#      ActionCable.server.broadcast 'room_channel_#{user.id}', render_message(message)
#    end
    ActionCable.server.broadcast 'room_#{message.room_id}_channel', render_message(message)
  end
  private
  def render_message message
    ApplicationController.renderer.render message
  end
end
