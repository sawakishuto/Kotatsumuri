class TodosController < ApplicationController
  def create
    begin
      @todo=Todo.create!{
        taskname=params[:task_name],
        discription=params[:discription],
        timing=params[:timing],
        priority=params[:priority],
        status=params[:status],
        duedate=params[:due_date]
        users_plants_id=params[:users_plants_id]
      }
    rescue
     render json:{message:"作成に失敗しました"}
    end
  end

  def show
    @todo=todo.findby(user_plants_id: params(:users_plants_id))
    render json: @todo
  end
end
