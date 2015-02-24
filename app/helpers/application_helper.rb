module ApplicationHelper
  

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def content_for_or_pjax(name, &block)
    request.headers['X-PJAX'] ? capture(&block) : content_for(name, &block)
  end

  def is_pjax
    return request.headers['X-PJAX']
  end

end
