class CreationsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  layout 'admin'

  def create_rfi
    rfi = Rfi.create!( user_id: current_user.id, 
                    title: "default")
    Category.create!( rfi_id: rfi.id,
                      text: "New Category")
    redirect_to action: 'show', id: rfi.id
  end

  def index
    redirect_to dashboard_index_path
  end

  def show
    @rfi = Rfi.find_rfi(params[:id], current_user.id)
    if (@rfi == nil)
      redirect_to dashboard_index_path
      return
    end
    set_rfi(@rfi)
    @categories = get_categories
    @active_category = set_active_category(get_categories.first)
    @activities = PublicActivity::Activity.order("created_at desc")
    render :index
  end

  def add_new_category
    text = find_available_text(get_categories, "New Category")
    set_active_category(Category.create!( rfi_id: get_current_rfi.id,
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
    redirect_to action: 'page_update'
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

  def add_question
    @category_id = get_active_category.id
    @qual = params[:qual]
    @quant = params[:quant]
    @text = params[:text]
    @impact = params[:impact].strip

    @question = Question.new( category_id: @category_id,
                                  qual: @qual,
                                  quant: @quant,
                                  text: @text,
                                  impact: @impact)
    if @question.save
      Response.set_empty_responses([@question], get_current_rfi.collaborators)
      collaborators = get_collaborators
      for collaborator in collaborators
        @question.create_activity :create, recipient: collaborator.user, owner: current_user
      end
      redirect_to action: 'update_active_category', category: @category_id
      return
    end
  end

  def delete_question
    question = Question.find_by_id(params[:question_id])
    collaborators = get_collaborators
    Question.destroy(params[:question_id])
    for collaborator in collaborators
      question.create_activity :delete, recipient: collaborator.user, owner: current_user, parameters: {rfi: get_current_rfi}
    end
    redirect_to action: 'update_active_category', category: params[:category_id]
    return
  end

  def page_update
    p '*' * 80
    @categories = get_categories
    @active_category = get_active_category
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

    def get_collaborators
      return $rfi.collaborators
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
