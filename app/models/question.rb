class Question < ActiveRecord::Base
  include PublicActivity::Common
	belongs_to :category
	has_many :responses, dependent: :destroy
	has_many :submissions, dependent: :destroy

end
