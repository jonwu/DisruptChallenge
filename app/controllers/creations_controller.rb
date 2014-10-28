class CreationsController < ApplicationController
  def index
    @rfi = Rfi.first
  end
end
