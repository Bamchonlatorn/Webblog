class Post < ApplicationRecord
  # ความสัมพันธ์
  belongs_to :user
  has_many :comments, dependent: :destroy # ลบคอมเมนต์ทั้งหมดเมื่อโพสต์ถูกลบ
  has_many :likes, dependent: :destroy    # ลบไลก์ทั้งหมดเมื่อโพสต์ถูกลบ

  # การตรวจสอบข้อมูล (Validations)
  validates :title, presence: true, length: { maximum: 255 } # ห้ามเว้นว่างและมีความยาวไม่เกิน 255 ตัวอักษร
  validates :content, presence: true                         # ห้ามเว้นว่างสำหรับเนื้อหาโพสต์

  # การจัดลำดับข้อมูล (Scopes)
  scope :recent, -> { order(created_at: :desc) } # ดึงข้อมูลโพสต์ล่าสุดขึ้นก่อน
  scope :search, ->(term) { where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%") if term.present? } # ค้นหาจาก title หรือ content

  after_initialize :set_default_content, if: :new_record?

  private


  # เมธอดตัวช่วย (Instance Methods)
  def author_name
    user.email # แสดงชื่อผู้เขียน (หรือเปลี่ยนเป็น user.name หากมีฟิลด์ name ใน User)
  end

  def set_default_content
    self.content ||= "Default content"
  end
  
end
