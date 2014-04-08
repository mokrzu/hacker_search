class Article < ActiveRecord::Base
  validates :source_id, presence: true, uniqueness: true
  validates :title, presence: true, allow_blank: false
  validates :content, presence:true, allow_blank: false

  update_index "article#article", :self, urgent: true
end
