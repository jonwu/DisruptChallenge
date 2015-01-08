class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :rfi 
  has_many :submissions
  validates :user_id, presence: true
  validates :rfi_id, presence: true
  validates_uniqueness_of :user_id, :scope => :rfi_id

  scope :scored_submissions, -> { joins(:submissions).where('submissions.score IS NOT null') }
  scope :order_by_score, -> {scored_submissions.select('collaborators.id', 'collaborators.user_id','sum(score) as total_score').group('collaborators.id').order('total_score desc')}
  
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

  def self.sort_by_score(collaborators)
    collaborator_scores = {}
    for collaborator in collaborators
      current_score = 0
      scored_submissions = collaborator.submissions.scored
      for submission in scored_submissions
        current_score += submission.score * convert_impact_to_scale(collaborator.rfi, submission.question)
      end
      collaborator_scores[collaborator.id] = current_score
    end
    # sorts in descending order by value
    return Hash[collaborator_scores.sort_by{|k, v| v}.reverse]
  end


  # Retrieves int values for a question's impact levels
  def self.convert_impact_to_scale(rfi, question)
    # rfi = submission.question.category.rfi
    impact = question.impact
    # rfi = Rfi.find_by_id(rfi_id)
    if impact.to_s == "low"
      return rfi.low
    elsif impact.to_s == "medium"
      return rfi.medium
    else
      return rfi.high
    end
  end

end
 