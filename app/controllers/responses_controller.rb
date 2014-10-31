class ResponsesController < ApplicationController
  def index
    # TODO: Need logic to get logged in User's RFIs.
    @rfi = Rfi.first
    @category = @rfi.categories.first
  end
end
