class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy]

  # GET /images or /images.json
  def index
    @images = Image.all.page(params[:page]).per(10)
  end

  # GET /images/1 or /images/1.json
  def show
    # @file_name = @image.file.file.filename
    # update_image_uri(@file_name)
    @file_size = file_size(@image)
    @tags = @image.tags.pluck(:name)
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
    @image.file.cache! unless @image.file.blank?
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:notice] = 'Image was successfully created.'
      redirect_to image_path(@image)
      # Tagging
      # 0. Retreive URL of the image file in S3: @image.file
      # 1. Based on the image file url of the S3, send a request to Clarifi, retrive taggings as an array
      # 2. Create each Tag based on taggings array
      # 3. Make a connection by posting ImageTag row to ImageTag through table
    else
      # @image.errors
      flash[:alert] = 'Something is wrong'
      render 'new'
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    if @image.update(image_params)
      flash[:notice] = 'Image was successfully updated.'
      redirect_to image_path(@image)
    else
      flash[:alert] = 'Something is wrong'
      render 'edit'
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    flash[:notice] = 'Image was successfully deleted.'
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:name, :file, :file_cache)
  end
end
