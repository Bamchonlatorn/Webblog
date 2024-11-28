class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true  # ตรวจสอบว่ามีเนื้อหา
end
