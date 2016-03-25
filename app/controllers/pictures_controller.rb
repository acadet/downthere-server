class PicturesController < ApplicationController

  include FilePickerModule

  def index
    @pictures = Picture.by_date.by_name

    respond_to do |f|
      f.html
      f.json { render json: @pictures, status: :ok }
    end
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture      = Picture.new
    upload = FilePickerModule.upload_picture params[:picture][:attachment]

    if upload.has_key? :error
      @error = upload[:error]
      render 'new'
    else
      @picture.name = upload[:filename]
      @picture.attachment = upload[:url]
      @picture.save
      redirect_to pictures_path
    end
  end

  def destroy
    @picture = Picture.find params[:id]
    FilePickerModule.delete @picture.attachment
    @picture.destroy
    redirect_to pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(:attachment)
  end
end
