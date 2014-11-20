class Submission < ActiveRecord::Base
	validates_uniqueness_of :collaborator_id, :scope => :response_id
  belongs_to :response
  belongs_to :collaborator

  # Given a question and list of collaborators, finds the submissions
  def self.find_submissions_from_collaborators(question, collaborator_list)
    collaborator_ids = collaborator_list.pluck(:id)
    return Submission.where("collaborator_id IN (?) AND question_id = " + question.id.to_s, collaborator_ids)
  end
end
