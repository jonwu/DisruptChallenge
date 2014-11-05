class Rfi < ActiveRecord::Base
  has_many :categories
  has_many :collaborators

  def self.find_rfi(id, current_user_id)
  	@rfi = Rfi.find_by(id: id, user_id: current_user_id)
  end


end
