class RoomsController < ApplicationController
  after_action :track_action
  before_action :logged_in_user
  # track events with ahoy_matey gem.
  def track_action
    ahoy.track "Viewed #{controller_name}##{action_name}", request.filtered_parameters
  end
 
  def show
    @messages = Message.all
    @users = User.all
    ahoy.track "Visit chat page", language: "Ruby"
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      message.broad_cast_message
    end 
  end

private
  def message_params
    params.require(:message).permit(:content)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end


end
