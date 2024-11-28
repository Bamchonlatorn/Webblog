class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  # Associations
  has_many :posts
  has_many :comments
  has_many :likes
  
  # Optional: หากต้องการความสัมพันธ์ที่เกี่ยวข้องกับการลบข้อมูลเช่นลบโพสต์หรือคอมเม้นต์เมื่อผู้ใช้ถูกลบ
  # dependent: :destroy จะทำให้โพสต์หรือคอมเม้นต์ถูกลบเมื่อผู้ใช้ถูกลบ
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

end
