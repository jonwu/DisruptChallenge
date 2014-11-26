class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :rfi 
  has_many :submissions
  validates :user_id, presence: true
  validates :rfi_id, presence: true
  validates_uniqueness_of :user_id, :scope => :rfi_id
  scope :order_by_score, -> {joins(:submissions).select('collaborators.id', 'collaborators.user_id','sum(submissions.score) as total_score').group('collaborators.id').order('total_score desc')}
  

  def self.find_collaborated_rfis(user_id)
    @rfis = []
    @collaborations = Collaborator.where("user_id = " + user_id.to_s).pluck(:rfi_id)
    @collaborations.each do |rfi_id|
      @rfis << Rfi.find_by_id(rfi_id)
    end
    return @rfis
  end

  def self.new_collaborator(user_id, rfi_id)
    @collaborator = Collaborator.new(user_id: user_id , rfi_id: rfi_id)
    if @collaborator.save
      return @collaborator
    end
    return nil
  end

  def self.delete_by_rfi_id(rfi_id)
    Collaborator.delete_all(rfi_id: rfi_id)
  end

  # Get all collaborators with RFI object, ordered by descending id.
  def self.get_collaborators(rfi)
    if !rfi.nil?
      return Collaborator.where(rfi_id: rfi.id).order("id DESC")
    end
    return nil
  end
end
 