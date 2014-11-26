class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :rfis
  has_many :collaborators
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
