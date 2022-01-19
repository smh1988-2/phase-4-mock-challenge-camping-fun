class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        activities = Activity.all
        render json: activities, status: :ok
    end

    def destroy
        activity = Activity.all.find(activity_params[:id])
        activity.destroy
        head :no_content 
    end

    private

    def activity_params
        params.permit(:id, :name, :age)
    end

    def render_not_found_response
        render json: { "error" => "Activity not found" }, status: :not_found
    end

end
