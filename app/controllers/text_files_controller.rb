class TextFilesController < ApplicationController
  def index
    @files = TextFile.by_name

    respond_to do |f|
      f.html
      f.json { render json: @files, status: :ok }
    end
  end

  def new
    @file = TextFile.new
  end

  def create
    @file      = TextFile.new text_file_params
    @file.name = @file.attachment.file.basename unless @file.attachment.file.nil?

    if @file.save
      redirect_to text_files_path
    else
      render 'new'
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
    @file.destroy
    redirect_to text_files_path
  end

  private
  def text_file_params
    params.require(:text_file).permit(:name, :attachment)
  end
end
