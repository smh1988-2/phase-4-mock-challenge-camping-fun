class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show
        camper = Camper.all.find(camper_params[:id])
        render json: camper, include: :activities, status: :ok
    end

    def create
        camper = Camper.create!(camper_params)

        if camper
            render json: camper, status: :created
        else
            render json: { "error" => "validation errors" } , status: :unprocessable_entity
        end
    end

    private

    def camper_params
        params.permit(:id, :name, :age)
    end

    def render_not_found_response
        render json: { "error" => "Camper not found" }, status: :not_found
    end

    def render_invalid
        render json: { "errors" => ["validation errors"] }, status: :unprocessable_entity
    end

end
