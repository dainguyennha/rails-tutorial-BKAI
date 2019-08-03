class SearchUsersController < ApplicationController
  def create
    @user = User.find_by email: params[:user][:user_name]
    @room = Room.find_by id: params[:user][:room_id]
    if @user && !@room.users.include?(@user)
      RoomUser.create user_id: @user.id, room_id: @room.id
    else
      flash[:warning] = "User is not found!"
      redirect_to room_path(params[:user][:room_id])
    end
  end

  private
end
