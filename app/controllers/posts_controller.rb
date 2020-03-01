class PostsController < ApplicationController
	before_action :authenticate_user!

  def spots_select
    if request.xhr?
      render partial: 'posts/spots', locals: {category_id: params[:category_id]}
    end
  end

	def new
		@spot = Spot.find(params[:id])
		@post = Post.new
		@post_image = @post.post_images.build
		@post.spot_id = @spot.id
	end

  def news
    @post = Post.new
    @spot = @post.spot
    @post_image = @post.post_images.build
  end

	def create
		if @spot != nil
			@spot = Spot.find(params[:post][:spot_id])
			@post = Post.new(post_params)
		else
			@post = Post.new(post_params)
			@spot = Spot.find(params[:spot][:spot])
		end
		@post.user_id = current_user.id
		@post.spot_id = @spot.id
		if @post.save
  		redirect_to post_path(@post.id)
		end
	end

	def show
		@post = Post.find(params[:id])
		@post_images = PostImage.where(post_id: @post.id)
	end

	def edit
		@post = Post.find(params[:id])
		@post_images = PostImage.where(post_id: @post.id)
	end

	def update
		@post = Post.find(params[:id])
		@spot = @post.spot
		@post.spot_id = @spot.id
		if @post.update(post_params)
			redirect_to post_path(@post.id)
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to mypage_path(current_user.id)
	end

	private
	def post_params
		params.require(:post).permit(:impression, :visit_date, :spot_id,
			post_images_attributes: [:id, :image, :_destroy])
	end
end