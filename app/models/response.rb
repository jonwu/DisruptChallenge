class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => :question_id
  after_initialize :init

  def init
    self.text ||= "" #will set the default value only if it's nil
  end

  # Set empty response for each question. Params take ARRAYS of questions and collaborators
  def self.set_empty_responses(questions, collaborators)
  	for collaborator in collaborators
      for question in questions
    		Response.create(question_id: question.id, user_id: collaborator.user.id)
    	end
    end
  end

  def self.get_rfi_responses(questions, user_id)
    question_ids = questions.pluck(:id)
    user_responses = Response.where("user_id = " + user_id.to_s + " AND question_id IN (?)", question_ids)
    return user_responses
  end

  

  
end
