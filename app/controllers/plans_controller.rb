class PlansController < ApplicationController
  before_action :authenticate_user!

  def autocomplete_spot
    spot_suggestions = Spot.autocomplete(params[:term]).pluck(:name)
    respond_to do |format|
      format.html
      format.json{
        render json: spot_suggestions
      }
    end
  end

  def spots_select
    if request.xhr?
      render partial: 'spots', locals: {category_id: params[:category_id]}
    end
  end

  def new
    @plan = Plan.find(params[:id])
    @destination = Destination.new
    @spot = Spot.new
  end

  def create
    @plan = Plan.new(plan_params)
    @user = current_user
    @plans = @user.plans
    @plan = @user.plans.create(plan_params)
    if @plan.save
      redirect_to new_plan_path(@plan.id)
    else
      render action: :index
    end
  end

  def index
    @user = current_user
    @plans = @user.plans
    @plan = Plan.new
  end

  def edit
    @plan = Plan.find(params[:id])
    @destination = Destination.where(plan_id: @plan.id)
  end

  def update
    @plan = Plan.find(params[:id])
    @destination = Destination.where(plan_id: @plan.id)
    @spot = Spot.find(params[:destination][:spot])

    if @destination.length == 0
      @destination = Destination.new
    else
      @destinatin.spot_id = @spot.id
    end

    if @plan.update(plan_params)
      redirect_to plans_path
    else
      render "edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to plan_path
  end

  private
  def plan_params
    params.require(:plan).permit(:name, :start_date, :end_date)
  end

  def nest_plan_params
    params.require(:plan).permit(:name, :start_date, :end_date,
      destinations_attributes: [:id, :time, :to_do, :to_go, :_destroy])
  end
end

