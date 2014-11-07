class Rfi < ActiveRecord::Base
  has_many :categories
  has_many :collaborators
  has_many :questions, through: :categories

  def self.find_rfi(id, current_user_id)
  	@rfi = Rfi.find_by(id: id, user_id: current_user_id)
  end

  def self.delete_rfi(id)
  	output = Rfi.destroy(id)
  	Collaborator.delete_by_rfi_id(id)
  end


end
