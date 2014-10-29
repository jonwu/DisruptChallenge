class ResponsesController < ApplicationController
  def index
    @rfi = Rfi.first
  end
end
