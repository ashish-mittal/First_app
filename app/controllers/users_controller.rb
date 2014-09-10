class UsersController < ApplicationController
 
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'Signed Up' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def index
    @us=User.all.order("created_at desc")
    @users=[]
    @us.each do |user|
        if user.created_at > 1.week.ago
          p 1.week.ago
          @users << user
        end
      end
  end

  def show
    @user=current_user
  end

  


  def edit
    @user=current_user
  end

  def update
    @user=current_user
    if @user.update_attributes(user_params)
      redirect_to user_path, notice: 'Profile has been successfully updated'
    end
  end
  
  
  private
    

    def user_params
      params.require(:user).permit(:username, :email, :password,:password_confirmation,:dob, :picture)
    end
end
