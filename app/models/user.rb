class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  # Associations
  has_many :posts, dependent: :destroy  # กำหนดความสัมพันธ์ว่าโพสต์จะถูกลบเมื่อผู้ใช้ถูกลบ
  has_many :comments, dependent: :destroy  # คอมเม้นต์จะถูกลบเมื่อผู้ใช้ถูกลบ
  has_many :likes, dependent: :destroy  # ไลค์จะถูกลบเมื่อผู้ใช้ถูกลบ
  has_many :post_likes, dependent: :destroy

end
