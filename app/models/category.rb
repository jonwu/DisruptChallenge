class Category < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :rfi

  

end
