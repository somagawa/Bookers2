class Book < ApplicationRecord
	validates :title, {presence: true}
	validates :body, {presence: true, length: { maximum: 200 }}
	belongs_to :user

def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
end

end
