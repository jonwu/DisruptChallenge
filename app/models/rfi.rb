class Rfi < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :questions, through: :categories

  def self.find_rfi(id, current_user_id)
  	@rfi = Rfi.find_by(id: id, user_id: current_user_id)
  end

  def self.delete_rfi(id)
  	output = Rfi.destroy(id)
  end


end
