class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path  # ส่งกลับไปที่หน้าล็อกอิน
  end
end
