class BlogsController < ApplicationController
   before_action :find_user
  
  def new
  	 @blog=@user.blogs.new
  end

  def index
    @blog=@user.blogs.new
	  @blogs=Blog.all.order(created_at: :desc)
		respond_to do |format|
			format.html
		end
  end

 def create
      @blog=@user.blogs.new(blog_params)
       respond_to do |format|
       		if @blog.save
        		format.html{redirect_to user_blogs_path,notice: 'Blog has been successfully created.' }
        		format.js
       			else
        
        		flash[:notice] = @blog.errors.full_messages.first
                format.html { redirect_to user_blogs_path }
            end
        end
 end

  def destroy
     @blog=current_user.blogs.find_by_id(params[:id])
    if @blog.destroy
      respond_to do |format|
      format.html { redirect_to user_blogs_path, notice: 'Blog has been successfully destroyed.' }
      format.json { head :no_content }
      end
    end
  end
  
  
 private

	def find_user
		@user=User.find(params[:user_id])
	end

    def blog_params
      params.require(:blog).permit(:title,:description,:user_id)
    end
end
