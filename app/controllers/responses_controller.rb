class ResponsesController < ApplicationController
  def index
    @rfi = Rfi.first
    @category = @rfi.categories.first
  end
end
