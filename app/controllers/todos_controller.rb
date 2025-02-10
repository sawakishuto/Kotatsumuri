class TodosController < ApplicationController
  def create
    begin
      user = @current_user
      plant_id = params[:todo_id]
      Rails.logger.debug "Plant ID: #{plant_id}"
      user_plants = UsersPlant.find_by(firebase_uid: user.firebase_uid, plant_id: plant_id)

      if user_plants.nil?
        render json: { message: "UsersPlant not found" }, status: :not_found
        return
      end

      todos_params.each do |todo_params|
        Todo.create!(
          taskname: todo_params[:taskname],
          discription: todo_params[:discription],
          timing: todo_params[:timing],
          priority: todo_params[:priority],
          status: todo_params[:status],
          duedate: todo_params[:duedate],
          users_plants_id: user_plants.id
        )
      end

      render json: { message: "作成に成功しました" }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { message: "作成に失敗しました: #{e.record.errors.full_messages.join(', ')}" }, status: :unprocessable_entity
    rescue => e
      render json: { message: "作成に失敗しました: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def show
    user = @current_user
    plant_id = params[:todo_id]
    Rails.logger.debug "Plant ID: #{plant_id}"
    user_plants = UsersPlant.find_by(firebase_uid: user.firebase_uid, plant_id: plant_id)

    if user_plants.nil?
      render json: { message: "UsersPlant not found" }, status: :not_found
      return
    end

    todos = Todo.where(users_plants_id: user_plants.id)
    render json: todos
  end

  private

  def todos_params
    params.require(:todos).map do |todo|
      todo.permit(:taskname, :discription, :timing, :priority, :status, :duedate)
    end
  end
end