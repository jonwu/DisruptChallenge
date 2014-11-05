class Collaborator < ActiveRecord::Base
  has_one :user
  belongs_to :rfi

  def self.find_collaborated_rfis(user_id)
    @rfis = []
    @collaborations = Collaborator.where("user_id = " + user_id.to_s).pluck(:rfi_id)
    @collaborations.each do |rfi_id|
      @rfis << Rfi.find_by_id(rfi_id)
    end
    return @rfis
  end
end
