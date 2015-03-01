class Question < ActiveRecord::Base
	belongs_to :category
	has_many :responses, dependent: :destroy
	has_many :submissions, dependent: :destroy
	has_many :comments, dependent: :destroy

  default_scope { order('created_at ASC') } 
end
