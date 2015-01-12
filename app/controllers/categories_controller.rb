class CategoriesController < BaseController
	layout 'main_template'
	
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

	
	
end
