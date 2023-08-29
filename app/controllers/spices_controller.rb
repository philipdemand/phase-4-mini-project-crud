class SpicesController < ApplicationController

    def index
        spices = Spice.all
        render json: spices
    end

    # def show
    #     spice = find_spice
    #     render json: spice
    #   rescue ActiveRecord::RecordNotFound
    #     render_not_found_response
    #   end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    rescue ActiveRecord::RecordNotFound
          render_not_found_response
    end

    def destroy
        spice = Spice.find_by(id: params[:id])
        if spice
          spice.destroy
          head :no_content
        else
          render json: { error: "Spice not found" }, status: :not_found
        end
     end

    private

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_spice
    Spice.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Spice not found" }, status: :not_found
  end

end
