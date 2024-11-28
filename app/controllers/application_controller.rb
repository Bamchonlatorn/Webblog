class ApplicationController < ActionController::Base
  before_action :authenticate_user!  # ตรวจสอบให้แน่ใจว่าผู้ใช้ล็อกอินแล้ว
  
  # กำหนดหน้า redirect หลังจากล็อกอิน
  def after_sign_in_path_for(resource)
    posts_path  
  end
end
