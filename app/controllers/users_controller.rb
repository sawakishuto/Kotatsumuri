class UsersController < ApplicationController
  def update_me
    user = User.find_by(firebase_uid: @current_user.firebase_uid)
    if user.nil?
      render json: { error: "User not found" }, status: :not_found
    else
      begin
      user.update!(
        name: params[:name], # nameに変更
      )
      puts user
      user.save!
      rescue => e
        render json: { error: e.message }, status: :bad_request
      end
      render json: user, status: :ok
    end
  end

  def login
    user = User.find_by(firebase_uid: @current_user.firebase_uid)
    if user.nil?
      render json: { error: "User not found" }, status: :not_found
    else
      render json: user, status: :ok
    end
  end
end
