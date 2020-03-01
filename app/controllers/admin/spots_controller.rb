class Admin::SpotsController < ApplicationController
	def new
		if admin_signed_in?
			@spot = Spot.new
		else
			redirect_to root_path
		end
	end

	def create
		@category = Category.find(params[:spot][:category_id])
		@spot = Spot.new(spot_params)
		@spot.category_id = @category.id
		if @spot.save
			flash[:success] = "観光地を登録しました。"
			redirect_to new_admin_spot_path
		else
			render 'new'
		end
	end

	def edit
		if admin_signed_in?
			@spot = Spot.find(params[:id])
		else
			redirect_to root_path
		end
	end

	def update
		@category = Category.find_by(name: params[:spot][:category_id])
		@spot = Spot.find(params[:id])
		@spot.category_id = @spot.category.id
		if @spot.update(spot_params)
			redirect_to admin_spot_path(params[:id])
		else
			render 'edit'
		end
	end

	def destroy
		@spot = Spot.find(params[:id])
		@spot.destroy
		redirect_to admin_spots_path
	end

	def index
		if admin_signed_in?
			@spots = Spot.all
		else
			redirect_to root_path
		end
	end

	def show
		if admin_signed_in?
			@spot = Spot.find(params[:id])
		else
			redirect_to root_path
		end
	end

	private
	def spot_params
		params.require(:spot).permit(:name, :address, :image, :content, :latitude, :longitude)
	end
end