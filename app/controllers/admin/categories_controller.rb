class Admin::CategoriesController < ApplicationController
	def index
		if admin_signed_in?
			@category = Category.new
			@categories = Category.all
		else
			redirect_to root_path
		end
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to admin_categories_path
		else
			render 'new'
		end
	end

	def edit
    if admin_signed_in?
			@category = Category.find(params[:id])
		else
			redirect_to root_path
		end
	end

	def update
		@category = Category.find(params[:id])
		if @category.update_attributes(category_params)
			redirect_to edit_admin_category_path
		else
			render 'edit'
		end
	end

	def destroy
		 Category.find(params[:id]).destroy
		 redirect_to new_admin_category_path
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end
end
