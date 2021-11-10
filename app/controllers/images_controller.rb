class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy]

  # GET /images or /images.json
  def index
    @images = Image.all.page(params[:page]).per(10)
  end

  # GET /images/1 or /images/1.json
  def show; end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit; end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      # @file_name = @image.file.file.filename

      # Tagging
      # 0. Retreive URL of the image file in S3: @image.file
      # 1. Based on the image file url of the S3, send a request to Clarifi, retrive taggings as an array
      # 2. Create each Tag based on taggings array
      # 3. Make a connection by posting ImageTag row to ImageTag through table
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:name, :file)
  end
end
