class Admin::PostsController < ApplicationController

	def autocomplete_spot
		spot_suggestions = Spot.autocomplete(params[:term]).pluck(:name)
		respond_to do |format|
			format.html
			format.json{
				render json: spot_suggestions
			}
		end
	end

	def show
		if admin_signed_in?
			@post = Post.find(params[:id])
			@post_images = PostImage.where(post_id: @post.id)
		end
	end

	def edit
		if admin_signed_in?
			@post = Post.find(params[:id])
			@post_image = PostImage.where(post_id: @post.id)
		else
			redirect_to root_path
		end
	end

	def update
		@spot = Spot.find_by(name: params[:post][:spot_id])
		@post = Post.find(params[:id])
		@post.spot_id = @spot.id
		if @post.update(post_params)
			redirect_to post_path(@post.id)
		else
			render 'edit'
		end
	end

	def index
		if admin_signed_in?
			@posts = Post.all
		else
			redirect_to root_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to mypage_path(current_user.id)
	end

	private
	def post_params
		params.require(:post).permit(:impression, :visit_date,
			post_images_attributes: [:id, :image, :_destroy])
	end
end