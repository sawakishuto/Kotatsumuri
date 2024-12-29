class PlantsController < ApplicationController

  def index
    query = params[:query]
    @plants = Plant.where("name LIKE ?", "%#{query}%").first
    @care_schedules = CareSchedule.where("plant_id = ?", @plants.id).first
    @care_periods = CarePeriod.where("care_schedule_id = ?", @care_schedules.id)
    @growth_conditions = GrowthCondition.where("plant_id = ?", @plants.id)
    render json: {
      plant: {
        name: @plants.name,
        description: @plants.description,
        care_schedules: @care_schedules,
        care_periods: @care_periods,
        growth_conditions: @growth_conditions
  }
    }
  end
end