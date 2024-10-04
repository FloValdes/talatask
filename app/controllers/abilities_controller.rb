class AbilitiesController < ApplicationController
  before_action :set_ability, only: %i[ show update destroy ]

  # GET /abilities
  def index
    @abilities = Ability.all

    render json: @abilities
  end

  # GET /abilities/1
  def show
    render json: @ability
  end

  # POST /abilities
  def create
    @ability = Ability.new(ability_params)

    if @ability.save
      render json: @ability, status: :created, location: @ability
    else
      render json: @ability.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /abilities/1
  def update
    if @ability.update(ability_params)
      render json: @ability
    else
      render json: @ability.errors, status: :unprocessable_entity
    end
  end

  # DELETE /abilities/1
  def destroy
    @ability.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability
      @ability = Ability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ability_params
      params.require(:ability).permit(:name)
    end
end
