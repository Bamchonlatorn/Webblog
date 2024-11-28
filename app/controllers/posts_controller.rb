class PostsController < ApplicationController 
  before_action :authenticate_user!  # ตรวจสอบให้แน่ใจว่าผู้ใช้ล็อกอินแล้ว
  before_action :set_post, only: [:show, :edit, :update, :destroy]  # กำหนดการตรวจสอบโพสต์ที่ต้องการแก้ไข, อัพเดต หรือ ลบ
  before_action :check_post_owner, only: [:edit, :update, :destroy]  # ตรวจสอบว่าเจ้าของโพสต์เป็นผู้ใช้ที่ล็อกอินอยู่

  def index
    # ถ้ามีคำค้นหาใน params[:search] ให้ทำการค้นหาโพสต์ที่มี title หรือ content ตรงกับคำค้น
    if params[:search].present?
      @posts = current_user.posts.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = current_user.posts  # ดึงโพสต์ทั้งหมดของผู้ใช้ที่ล็อกอิน
    end

    @my_post = Post.find_by(title: 'My Post')  # ค้นหาโพสต์ที่มี title เป็น 'My Post'
    
    # ดึงข้อมูลจากผู้ใช้ที่มี id = 1
    user = User.find(1)
    @user_posts = user.posts  # ดึงโพสต์ทั้งหมดที่ผู้ใช้สร้าง

    # ดึงโพสต์ที่มี id = 1
    @post = Post.find(1)
    
    # ดึงคอมเม้นต์ทั้งหมดที่อยู่ใต้โพสต์นี้
    @comments = @post.comments

    # เพิ่มคอมเม้นต์ใหม่ใต้โพสต์
    @new_comment = @post.comments.create(content: "Great post!", user_id: current_user.id)
  end

  def new
    @post = Post.new  # สร้างโพสต์ใหม่
  end

  def create
    @post = current_user.posts.new(post_params)  # ใช้ current_user เชื่อมโยงโพสต์กับผู้ใช้ที่ล็อกอิน
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    # @post ถูกกำหนดแล้วใน before_action :set_post
  end

  def edit
    # @post ถูกกำหนดแล้วใน before_action :set_post
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])  # ค้นหาโพสต์ตาม id
  end

  def check_post_owner
    # ตรวจสอบว่าโพสต์นี้เป็นของผู้ใช้ที่ล็อกอินหรือไม่
    redirect_to posts_path, alert: "You are not authorized to edit this post" unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :content)  # กำหนดว่าอนุญาตให้ส่งค่า title และ content ได้
  end
end
