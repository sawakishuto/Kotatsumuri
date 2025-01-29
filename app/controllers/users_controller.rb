class UsersController < ApplicationController
  def update
    user = User.find(@current_user.id)
    user.update_attribute(
      name: params[:name],
    )
    render json: user
  end
end
