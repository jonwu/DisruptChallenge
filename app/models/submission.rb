class Submission < ActiveRecord::Base
	validates_uniqueness_of :collaborator_id, :scope => :response_id
  belongs_to :response
  belongs_to :question
  belongs_to :collaborator

  # Given a question and list of collaborators, finds the submissions
  def self.find_submissions_from_collaborators(question, collaborator_list)
    collaborator_ids = collaborator_list.pluck(:id)
    return Submission.where("collaborator_id IN (?) AND question_id = " + question.id.to_s, collaborator_ids)
  end

  # Given a collaborator, returns a list of scores, one for each category in rfi
  def self.calculate_score_for_all_categories(categories, collaborator)
    scores = []
    # data assumes labels in chart are in same order as given here!
    for category in categories
      score = calculate_score_for_category(category, collaborator)
      scores.push(score)
    end
    return scores
  end

  # Calculates the score for a single category
  def self.calculate_score_for_category(category, collaborator)
    score = 0
    for question in category.questions.all
      submission = Submission.where("collaborator_id = " + collaborator.id.to_s + " AND question_id = " + question.id.to_s)
      if submission.exists?
        # where returns multiple, so need the first. Assumes only one.
        score += calculate_score_from_submission(submission.first)
      end
    end
    return score
  end

  # Score for a single question
  def self.calculate_score_from_submission(submission)
    impact = submission.question.impact
    scale = convert_impact_to_scale(submission, impact)
    # need to set max score in rfi schema
    return submission.score.to_f / 10 * scale
  end

  # Retrieves int values for a question's impact levels
  def self.convert_impact_to_scale(submission, impact)
    rfi = submission.question.category.rfi
    if impact.to_s == "low"
      return rfi.low
    elsif impact.to_s == "medium"
      return rfi.medium
    else
      return rfi.high
    end
  end
end
