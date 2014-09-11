class SessionsController < ApplicationController
 def new
  if current_user!=nil
    redirect_to user_path(current_user.id) 
  end
 end
  
  def create  
    user = User.where("email = ? or username = ?",params[:email],params[:username]).first
    if user  && User.authenticate(params[:password])
      session[:user_id] = user.id  
      redirect_to user_blogs_path(user.id)  
    else  
      flash.now.alert = "The email or password you entered is incorrect."  
      render "new"  
    end  
  end  

  def destroy  
    session[:user_id] = nil  
    redirect_to root_url, :notice => "Logged out!"  
  end  

end



