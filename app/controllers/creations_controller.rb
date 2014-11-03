class CreationsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  
  def index
    @rfi = get_current_rfi
    @categories = @rfi.categories.all
    @active_category = @categories.first
  end

  def add_new_category
    # get current Rfi
    @rfi = get_current_rfi
    @categories = @rfi.categories.all
    text = find_available_text(@categories, "default")
    @active_category = Category.create!( rfi_id: get_current_rfi.id,
                  text: text)
  end 

  def update_active_category
    @active_category = Category.find_by_id(params[:category])
  end

  def make_category_form
    @active_category = Category.find_by_id(params[:category])
  end

  def update_category_titles
    # get current Rfi
    @rfi = get_current_rfi
    @categories = @rfi.categories.all
    @active_category = Category.find_by_id(params[:category_id])
    text = params[:category_title]
    # only update if the name actually changed
    if @active_category.text.to_s != params[:category_title].to_s
      text = find_available_text(@categories, text)
      @active_category.update_attributes(:text => text)
    end
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
    p "*"*80
    p @category

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

  private
    def get_current_rfi
      return current_user.rfis.first
    end

    def find_available_text(categories, text)
      count = 1
      while categories.where(text: "_"*count + text).count > 0 do
        count = count + 1
      end
      return "_"*count + text
    end
end
