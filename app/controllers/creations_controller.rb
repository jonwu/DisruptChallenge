class CreationsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  
  def create_rfi
    @rfi = Rfi.new(user_id: current_user.id)
    if @rfi.save
      category = Category.create( rfi_id: @rfi.id,
                                  text: "New Category")
      redirect_to load_rfi_path(@rfi.id)
      return
    end
  end

  def load_rfi
    @rfi = Rfi.find_rfi(params[:rfi_id], current_user.id)
    if (@rfi == nil)
      redirect_to dashboard_index_path
      return
    end

    set_rfi(@rfi)
    @categories = get_categories
    @active_category = set_active_category(get_categories.first)
    render :index
  end

  def index
    redirect_to dashboard_index_path
  end

  def add_new_category
    # get current Rfi
    @rfi = get_current_rfi
    @categories = get_categories
    text = find_available_text(@categories, "New Category")
    @active_category = set_active_category(Category.create!( rfi_id: get_current_rfi.id,
                  text: text))
    redirect_to action: 'page_update'
  end 

  def delete_category
    id = params[:category_id]
    @active_category = set_active_category(find_next_category_and_delete(id))
    redirect_to action: 'page_update'
  end

  def update_active_category
    @active_category = set_active_category(Category.find_by_id(params[:category]))
    redirect_to action: 'page_update', no_refresh: true
  end

  def make_category_form
    @active_category = set_active_category(Category.find_by_id(params[:category]))
  end

  def update_category_titles
    # get current Rfi
    @rfi = get_current_rfi
    @categories = get_categories
    @active_category = set_active_category(Category.find_by_id(params[:category_id]))
    text = params[:category_title]
    # only update if the name actually changed
    if @active_category.text.to_s != params[:category_title].to_s
      text = find_available_text(@categories, text)
      @active_category.update_attributes(:text => text)
    end
    redirect_to action: 'page_update'
  end

  def check_question
    @active_category_id = params[:category]
  end

  def add_question
    @category_id = params[:category] 
    @qual = params[:qual]
    @quant = params[:quant]
    @text = params[:text]
    @impact = params[:impact]

    @question = Question.new( category_id: @category_id,
                                  qual: @qual,
                                  quant: @quant,
                                  text: @text,
                                  impact: @impact)
    if @question.save
      redirect_to action: 'update_active_category', category: @category_id
      return
    end
  end

  def delete_question
    Question.destroy(params[:question_id])
    redirect_to action: 'update_active_category', category: params[:category_id]
    return
  end

  def page_update
    @categories = get_categories
    @active_category = get_active_category
    @no_refresh = params[:no_refresh]
  end

  private
    $rfi
    $active_category

    def set_rfi(rfi)
      $rfi = rfi
    end

    def get_current_rfi
      return $rfi
      # return current_user.rfis.first
    end

    def set_active_category(active_category)
      $active_category = active_category
      return $active_category
    end

    def get_active_category
      return $active_category
    end

    def get_categories
      return $rfi.categories.all
    end

    def find_available_text(categories, text)
       count = 0
       text = text.strip

       if categories.find_by(text: text) != nil
          count = 1
          while categories.find_by(text: text +" ("+count.to_s+")") != nil do
           count = count + 1
         end  
       else
         return text
       end
         
       return text +" ("+count.to_s+")"
    end

    def find_next_category_and_delete(current_category_id)
      # render no category page
      ret = nil
      if get_categories.count > 1
        ret = Category.where("id < " + current_category_id).last
        if ret == nil
          ret = Category.where("id > " + current_category_id).first
        end
      end
      Category.destroy(current_category_id)
      return ret
    end

end
