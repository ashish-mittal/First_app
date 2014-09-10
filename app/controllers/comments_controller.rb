class CommentsController < ApplicationController
  
  def new
  		@blog=Blog.find(params[:blog_id])
  		@comment = @blog.comments.new
  end

  def create
  	  @blog=Blog.find(params[:blog_id])
  		@comment = @blog.comments.build(:user_id => current_user.id, :comment => params[:comment][:comment]) 
      if @comment.save
         redirect_to blog_comments_path,notice: 'comment has been successfully created.' 
       else
        redirect_to blog_comments_path,notice: 'comment not saved as their is no content'
      end

  end

  def index
    @blog=Blog.find(params[:blog_id])
    @comment = @blog.comments.new
    @comments=@blog.comments.all.order(created_at: :desc)
  end

  
    def blog_params
      params.require(:comment).permit(:comment,:blog_id,:user_id)
    end
end

