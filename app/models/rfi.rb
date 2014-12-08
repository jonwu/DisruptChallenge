class Rfi < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :questions, through: :categories
  has_many :responses, through: :questions
  has_many :submissions, through: :questions
  belongs_to :user
  after_initialize :init

  def init
    #will set the default value only if it's nil
    self.low ||= 1
    self.medium ||= 2
    self.high ||= 3
  end

  def self.find_rfi(id, current_user_id)
  	@rfi = Rfi.find_by(id: id, user_id: current_user_id)
  end

  def self.delete_rfi(id)
  	output = Rfi.destroy(id)
  end


end
