=begin
class PhotosController < ApplicationController

  def create
     	@photo = Photo.new(photo_params)
        @photo.save
   end

 private

 	end
   def photo_params
      params.require(:photo).permit(:album_id, :image)
   end
end
=end
