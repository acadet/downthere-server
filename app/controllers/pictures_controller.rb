class PicturesController < ApplicationController
  def index
    @pictures = Picture.by_name

    respond_to do |f|
      f.html
      f.json { render json: @pictures, status: :ok }
    end
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new picture_params

    if @picture.save
      redirect_to pictures_path
    else
      render 'new'
    end
  end

  def destroy
    @picture = Picture.find params[:id]
    @picture.destroy
    redirect_to pictures_path
  end

  private
  def picture_params
    params.require(:picture).permit(:name, :attachment)
  end
end
