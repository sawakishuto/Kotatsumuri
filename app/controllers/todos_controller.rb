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
        puts todo_params.inspect
        Todo.create!(
          task_name: todo_params[:task_name],
          description: todo_params[:description],
          timing: todo_params[:timing],
          priority: todo_params[:priority],
          status: todo_params[:status],
          due_date: todo_params[:due_date],
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
    puts user_plants.inspect

    if user_plants.nil?
      render json: { message: "UsersPlant not found" }, status: :not_found
      return
    end

    todos = Todo.where(users_plants_id: user_plants.id)
    todos.map do |todo|
      if todo[:priority] == 'high'
        todo[:priority] = "高"
      elsif todo[:priority] == 'medium'
        todo[:priority] = "中"
      elsif todo[:priority] == 'low'
        todo[:priority] = "低"
      end
      if todo[:status] == 'notStarted'
        todo[:status] = "未着手"
      elsif todo[:status] == 'done'
        todo[:status] = "完了"
      end
    end
    render json: todos
  end

  private

  def todos_params
    params.require(:todos).map do |todo|
      todo.permit(:task_name, :description, :timing, :priority, :status, :due_date)
    end
  end
end