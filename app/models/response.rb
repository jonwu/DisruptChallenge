class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => :question_id
  after_initialize :init
  scope :not_empty, -> {where.not(text: '')}

  default_scope { order('created_at ASC') } 

  def init
    self.text ||= "" #will set the default value only if it's nil
  end


  # should only return one response!
  def self.get_user_response(question_id, user_id)
    return Response.find_by_user_id_and_question_id(user_id, question_id)
  end

  def self.update_response_text(question_id, text, user_id)
    response = Response.get_user_response(question_id, user_id)
    if response.nil?
      Response.create(question_id: question_id, user_id: user_id, text: text)
    else
      response.update(text: text)
    end
    return
  end

  # Set empty response for each question. Params take ARRAYS of questions and collaborators
  def self.set_empty_responses(questions, collaborators)
  	for collaborator in collaborators
      for question in questions
    		Response.create(question_id: question.id, user_id: collaborator.user.id) # text by default is empty
    	end
    end
  end

  # For a set of questions, most likely from a particular category
  def self.get_rfi_responses(questions, user_id)
    question_ids = questions.pluck(:id)
    user_responses = Response.where("user_id = " + user_id.to_s + " AND question_id IN (?)", question_ids)
    return user_responses
  end

  # returns responses across all categories in rfi
  def self.get_all_rfi_responses(categories, user_id)
    question_ids = Question.where("category_id IN (?)", categories.pluck(:id)).pluck(:id)
    user_responses = Response.where("user_id = " + user_id.to_s + " AND question_id IN (?)", question_ids)
    return user_responses
  end


end
