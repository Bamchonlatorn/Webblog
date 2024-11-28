class ApplicationController < ActionController::Base
  # รีไดเร็กต์ไปที่หน้า posts index เมื่อผู้ใช้ล็อกอินสำเร็จ
  def after_sign_in_path_for(resource)
    posts_path  # หรือ user_posts_path(resource) ถ้าคุณอยากให้ไปที่โพสต์ของผู้ใช้
  end
end
