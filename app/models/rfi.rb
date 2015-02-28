class Rfi < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :vendors, dependent: :destroy
  # has_many :collaborators, dependent: :destroy
  has_many :questions, through: :categories
  has_many :responses, through: :questions
  has_many :submissions, through: :questions
  belongs_to :user
  after_initialize :init

  default_scope { order('created_at ASC') } 

  #retreive invited (vendor) rfis
  scope :invited, ->(user) { joins(:vendors).where(vendors: {user_id: user.id}) }
  # scope :invited, ->(user) { joins(:collaborators).where(collaborators: {user_id: user.id}) }


  def init
    #will set the default value only if it's nil
    self.low ||= 1
    self.medium ||= 2
    self.high ||= 3
  end

  def self.find_rfi(id, current_user_id)
    @rfi = Rfi.find_by(id: id, user_id: current_user_id)
    
    if @rfi.nil?
      @rfi = Rfi.find_collaborated_rfis(current_user_id).find_by(id: id)
    else
      
    end
  end

  def self.delete_rfi(id)
  	output = Rfi.destroy(id)
  end

  def self.find_collaborated_rfis(user_id)


    rfis = []
    collaborations = Collaborator.where("user_id = " + user_id.to_s).pluck(:rfi_id)
    collaborations.each do |rfi_id|
      rfis << Rfi.find_by_id(rfi_id)
    end
    return rfis
  end

end
