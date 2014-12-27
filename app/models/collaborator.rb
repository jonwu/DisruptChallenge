class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :rfi 
  has_many :submissions
  validates :user_id, presence: true
  validates :rfi_id, presence: true
  validates_uniqueness_of :user_id, :scope => :rfi_id
  scope :order_by_score, -> {joins(:submissions).select('collaborators.id', 'collaborators.user_id','sum(submissions.score) as total_score').where('submissions.score IS NOT null').group('collaborators.id').order('total_score desc')}
  
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

end
 