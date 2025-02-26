class PlantsController < ApplicationController
  def index
    query = params[:query]
    response = Services::SearchPlant.new.call(query)
    render json: response
  end
end
