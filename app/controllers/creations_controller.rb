class CreationsController < ApplicationController
  respond_to :html, :js

  def index
    @rfi = Rfi.first
    @categories = @rfi.categories.all
    @active_category = @categories.first
  end

  def update_category
    @active_category = Category.find_by_id(params[:category])
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
      redirect_to action: 'update_category', category: @category_id
    end
  end
end
