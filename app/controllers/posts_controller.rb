class PostsController < ApplicationController
  def index
    @posts = Post.all.paginate(page: params[:page], per_page: 1)
    @posts_by_month = Post.find(:all, :order => 'created_at DESC').group_by { |post| post.created_at.strftime("%B %Y") }
  end



  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
  if @post.save
    flash[:notice] = "Your post has been created"
    redirect_to @post
  end
end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image)
  end


end
