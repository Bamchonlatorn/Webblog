class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update] # ตรวจสอบให้แน่ใจว่าผู้ใช้ล็อกอินแล้ว
  before_action :set_post, only: [:show, :edit, :update, :destroy]  # กำหนดการตรวจสอบโพสต์ที่ต้องการแก้ไข, อัพเดต หรือ ลบ
  before_action :check_post_owner, only: [:edit, :update, :destroy]  # ตรวจสอบว่าเจ้าของโพสต์เป็นผู้ใช้ที่ล็อกอินอยู่

  def index
    if user_signed_in?
      if params[:search].present?
        @posts = current_user.posts.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      else
        @posts = current_user.posts  # ดึงโพสต์ทั้งหมดของผู้ใช้ที่ล็อกอิน
      end
    else
      # Handle the case where the user is not logged in, for example, redirect to login page
      redirect_to new_user_session_path, alert: "You need to sign in first."
    end
  end
  

  def new
    @post = Post.new  # สร้างโพสต์ใหม่
  end

  def create
    @post = current_user.posts.new(post_params)  # ใช้ current_user เชื่อมโยงโพสต์กับผู้ใช้ที่ล็อกอิน
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new  # ถ้ามีข้อผิดพลาดจะกลับไปที่หน้า new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments    # ดึงคอมเมนต์ทั้งหมดของโพสต์นี้
    @like = Like.new

  end

  def edit
    # @post ถูกกำหนดแล้วใน before_action :set_post
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit  # ถ้ามีข้อผิดพลาดจะกลับไปที่หน้า edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    else
      redirect_to posts_url, alert: 'You are not authorized to delete this post.'
    end
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
