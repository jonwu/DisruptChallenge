class Submission < ActiveRecord::Base
	validates_uniqueness_of :collaborator_id, :scope => :response_id
end
