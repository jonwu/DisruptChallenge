class CategoriesController < BaseController
	
	respond_to :html, :js

	def show
		authenticate_category(params[:id])
		initialize_template
	end

	def categories
		@path = category_path
		current_category = get_current_rfi.categories.find_by_id(params[:category_id])
		set_current_category(current_category)
		initialize_template
	end

	def new
		authenticate_rfi(params[:rfi_id])
		text = Category.find_available_text(get_categories, "New Category")
		set_current_category(Category.create!( rfi_id: get_current_rfi.id, text: text))
		initialize_template
		redirect_to category_questions_path(category_id: get_current_category.id)
	end

	def destroy
		authenticate_category(params[:id])
		set_current_category(Category.find_next_category_and_delete(get_categories, params[:id]))
		initialize_template
		redirect_to rfis_path
	end

	def update
		p '*' * 80
		p params
		authenticate_category(params[:id])
		get_current_category.update_attributes!(text: params[:category][:text])
		initialize_template
	end


	
	
	
end
