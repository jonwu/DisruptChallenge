class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  def self.set_empty_responses(questions, collaborator_id)
  	for question in questions
  		Response.create(question_id: question.id, user_id: collaborator_id, text: "")
  	end
  end

  def self.get_rfi_responses(questions, user_id)
    question_ids = questions.pluck(:id)
    user_responses = Response.where("user_id = " + user_id.to_s + " AND question_id IN (?)", question_ids)
    return user_responses
  end

  

  
end
