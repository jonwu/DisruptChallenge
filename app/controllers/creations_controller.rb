class CreationsController < ApplicationController
  respond_to :html, :js
  before_action :authenticate_user!
  layout 'admin'

  def create_rfi
    rfi = Rfi.create!( user_id: current_user.id, 
                    title: "default")
    Category.create!( rfi_id: rfi.id,
                      text: "New Category")
    # redirect_to action: 'show', id: rfi.id
    redirect_to creation_path(id: rfi_id)
  end

  def index
    redirect_home
  end

  def show
    @rfi = Rfi.find_rfi(params[:id], current_user.id)
    if (@rfi == nil)
      redirect_home
      return
    end
    set_rfi(@rfi)
    @categories = get_categories
    @active_category = set_active_category(get_categories.first)
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  def add_new_category
    text = Category.find_available_text(get_categories, "New Category")
    set_active_category(Category.create!( rfi_id: get_current_rfi.id, text: text))
    redirect_to creations_page_update_path
  end 

  def delete_category
    id = params[:category_id]
    set_active_category(Category.find_next_category_and_delete(id))
    redirect_to creations_page_update_path
  end

  def update_active_category
    set_active_category(Category.find_by_id(params[:category]))
    redirect_to creations_page_update_path
  end

  def make_category_form
    @active_category = set_active_category(Category.find_by_id(params[:category]))
  end

  def update_category_titles
    # get current Rfi
    @active_category = set_active_category(Category.find_by_id(params[:category_id]))
    text = params[:category_title]
    # only update if the name actually changed
    if @active_category.text.to_s != params[:category_title].to_s
      text = Category.find_available_text(@categories, text)
      @active_category.update_attributes(:text => text)
    end
    redirect_to creations_page_update_path
  end

  def add_question
    category_id = get_active_category.id
    question = Question.create( category_id: category_id,
                                  qual: params[:qual],
                                  quant: params[:quant],
                                  text: params[:text],
                                  impact: params[:impact].strip)
    Response.set_empty_responses([question], get_current_rfi.collaborators)
    for collaborator in get_collaborators
      question.create_activity :create, recipient: collaborator.user, owner: current_user
    end
    # redirect_to action: 'update_active_category', category: category_id
    redirect_to creations_update_active_category_path(category: category_id)
    return
  end

  def delete_question
    question = Question.find_by_id(params[:question_id])
    Question.destroy(params[:question_id])
    for collaborator in get_collaborators
      question.create_activity :delete, recipient: collaborator.user, owner: current_user, parameters: {rfi: get_current_rfi}
    end
    # redirect_to action: 'update_active_category', category: params[:category_id]
    redirect_to creations_update_active_category_path(category: params[:category_id])
    return
  end

  def page_update
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
end
