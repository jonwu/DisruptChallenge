class CreationsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  
  def index
    @rfi = get_current_rfi
    @categories = @rfi.categories.all
    @active_category = @categories.first
  end

  def add_new_category
    count = Category.count + 1
    @active_category = Category.create!( rfi_id: get_current_rfi.id,
                  text: "default" + count.to_s)
    # get current Rfi
    @rfi = get_current_rfi
    @categories = @rfi.categories.all

  end 

  def update_active_category
    @active_category = Category.find_by_id(params[:category])
  end

  def make_category_form
    @active_category = Category.find_by_id(params[:category])
  end

  def update_category_titles
    @active_category = Category.find_by_id(params[:category_id])
    @active_category.update_attributes(:text => params[:category_title])
    # get current Rfi
    @rfi = get_current_rfi
    @categories = @rfi.categories.all
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
    end
  end

  def delete_question
    Question.destroy(params[:question_id])
    redirect_to action: 'update_active_category', category: params[:category_id]
  end

  private
    def get_current_rfi
      return current_user.rfis.first
    end
end
