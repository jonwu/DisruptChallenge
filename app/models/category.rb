class Category < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  belongs_to :rfi

  default_scope { order('created_at ASC') } 


  def self.find_available_text(categories, text)
     count = 0
     text = text.strip

     if categories.find_by(text: text) != nil
        count = 1
        while categories.find_by(text: text +" ("+count.to_s+")") != nil do
         count = count + 1
       end  
     else
       return text
     end
       
     return text +" ("+count.to_s+")"
  end
  
  def self.find_next_category_and_delete(categories, current_category_id)
    # render no category page
    ret = nil
    if categories.count > 1
      ret = Category.where("id < " + current_category_id).last
      if ret == nil
        ret = Category.where("id > " + current_category_id).first
      end
    end
    Category.destroy(current_category_id)
    return ret
  end

end
