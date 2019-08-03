class RoomsController < ApplicationController
  before_action :logged_in_user
  before_action :all_users
  before_action :check_mems_room, only: [:show]
 
  def index
    @rooms = current_user.rooms

  end

  def show
    @message = Message.new
    @room = Room.find_by id: params[:id]
    @messages = @room.messages
  end

  def create
  end


private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def all_users
    @users = User.is_online
  end

  def check_mems_room
    @room = Room.find_by id: params[:id] 
    redirect_to rooms_url if !@room.users.include?(current_user)
  end
end
