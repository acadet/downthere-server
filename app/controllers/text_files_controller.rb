class TextFilesController < ApplicationController

  include FilePickerModule

  def index
    @files = TextFile.by_date.by_name

    respond_to do |f|
      f.html
      f.json { render json: @files, status: :ok }
    end
  end

  def new
    @file = TextFile.new
  end

  def create
    @file      = TextFile.new
    upload = FilePickerModule.upload_text_file text_file_params[:attachment]

    if upload.has_key? :error
      @error = upload[:error]
      render 'new'
    else
      @file.name = upload[:filename]
      @file.attachment = upload[:url]
      @file.save
      redirect_to text_files_path
    end
  end

  def show
    @file = TextFile.find(params[:id])

    respond_to do |f|
      f.html
      f.json { render json: @file, status: :ok }
    end
  end

  def destroy
    @file = TextFile.find params[:id]
    FilePickerModule.delete @file.attachment
    @file.destroy
    redirect_to text_files_path
  end

  private
  def text_file_params
    params.require(:text_file).permit(:name, :attachment)
  end
end
