class AlbumsController < ApplicationController
 before_action :find_user
  def new
     @album = @user.albums.build
  end

	def create
    @album = @user.albums.build(album_params)
    if @album.save
      # to handle multiple images upload on create
      if params[:images]
        params[:images].each { |image|
          @album.photos.create(image: image)
        }
      end
      flash[:notice] = "Your album has been created."
      redirect_to user_albums_path(@user)
    else 
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def index
    @albums = @user.albums.all.order('created_at desc')
  end

  def show
    @album=@user.albums.find(params[:id])
    @photos=@album.photos.all
  end

  def edit
    @album = @user.albums.find(params[:id])
  end

  def update
    @album = @user.albums.find(params[:id])
    if @album.update(params[:album].permit(:title,:description))
      # to handle multiple images upload on update when user add more picture
      if params[:images]
        params[:images].each { |image|
          @album.photos.create(image: image)
        }
      end
      flash[:notice] = "Album has been updated."
      redirect_to current_user
    else
      render :edit
    end
  end

private
    
  def find_user
        @user=User.find(params[:user_id])
  end

	def album_params
		params.require(:album).permit(:title,:description,:user_id)
	end

end
