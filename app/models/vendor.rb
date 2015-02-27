class Vendor < ActiveRecord::Base
  belongs_to :user
  belongs_to :rfi 
  has_many :submissions
  validates :user_id, presence: true
  validates :rfi_id, presence: true
  validates_uniqueness_of :user_id, :scope => :rfi_id

  default_scope { order('created_at ASC') } 
  
  def self.new_vendor(user_id, rfi_id)
    @vendor = Vendor.new(user_id: user_id , rfi_id: rfi_id)
    if @vendor.save
      return @vendor
    end
    return nil
  end
  
  def self.delete_by_rfi_id(rfi_id)
    Vendor.delete_all(rfi_id: rfi_id)
  end

end
 