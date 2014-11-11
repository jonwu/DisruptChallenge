class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def self.get_rfi_responses(questions, user_id)
    question_ids = questions.pluck(:id)
    user_responses = Response.where("user_id = " + user_id.to_s + " AND question_id IN (?)", question_ids)
    return user_responses
  end

  
end
