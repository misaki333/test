class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @spot = Spot.find(params[:spot_id])
    like = current_user.likes.build(spot_id: params[:spot_id])
    like.save
  end
  def destroy
    @spot = Spot.find(params[:spot_id])
    like = Like.find_by(spot_id: params[:spot_id], user_id: current_user.id)
    like.destroy
  end

  def index
    @user = current_user
    @likes = @user.likes
  end

  def destroy_all
    @likes = Like.where(id: params[:likes])
    @likes.destroy_all
    redirect_to likes_path
  end
end
