class Submission < ActiveRecord::Base

  validates_uniqueness_of :collaborator_id, :scope => :response_id
  belongs_to :response
  belongs_to :question
  belongs_to :collaborator
  scope :is_null, -> {select('id').where('score IS null')}
  scope :scored, -> { where('score IS NOT null') }
  
  default_scope { order('created_at ASC') } 

  # Given a question and list of collaborators, finds the submissions in descending order by id
  def self.find_submissions_from_collaborators(question, collaborator_list)
    collaborator_ids = collaborator_list.pluck(:id)
    return Submission.where("collaborator_id IN (?) AND question_id = " + question.id.to_s, collaborator_ids).order("id DESC")
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

  def self.get_last_updated(collaborator)
    if collaborator.submissions.exists?
      return collaborator.submissions.order("updated_at DESC").first.updated_at
    end

    return nil
  end

  # Gets number of unrated questions for each category
  def self.get_number_unrated(categories, collaborator_list)
    unrated_by_category = {}
    collaborator_ids = collaborator_list.pluck(:id)
    for category in categories
      count = 0
      for question in category.questions
        count += Submission.where("collaborator_id IN (?) AND question_id = " + question.id.to_s + " AND score IS null", collaborator_ids).count
      end
      unrated_by_category[category.id] = count
    end
    return unrated_by_category
  end
end