class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    @message = current_user.messages.build message_params
    if @message.save
      @message.broad_cast_message
    end
  end

  private

  def message_params
    params.require(:message).permit :room_id, :content
  end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

end
