class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy]

  # GET /images or /images.json
  def index
    @tags = current_user.tags
    @order = params[:sort_by] || 'asc'
    @keyword = params[:search] ? params[:search].strip.downcase : ''
    @images = current_user.images_search_by(@keyword).sort_by_order(@order).add_pagenation(params[:page])
  end

  # GET /images/1 or /images/1.json
  def show; end

  # GET /images/new
  def new
    @image = current_user.images.new
  end

  # GET /images/1/edit
  def edit
    @image.file.cache! unless @image.file.blank?
  end

  # POST /images or /images.json
  def create
    @image = current_user.images.new(image_params)
    respond_to do |format|
      if @image.save
        @status = 'success'
        format.js { flash[:notice] = 'Image was successfully created.' }
      else
        @status = 'fail'
        @image.errors.full_messages.each do |msg|
          format.js { flash[:alert] = msg }
        end
      end
    end
  end

  def taggings
    @keywords = params[:keywords].uniq
    @keywords.each_with_index do |keyword, index|
      tag = Tag.find_by(name: keyword) || current_user.tags.create(name: keyword)
      current_user.image_tags.create(image_id: params[:imageid], tag_id: tag.id)
      break if index > 9
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params) && params[:image][:file]
        remove_current_tags(@image)
        @status = 'success'
        format.js { flash[:notice] = 'Image was successfully updated.' }
      elsif @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        @status = 'fail'
        @image.errors.full_messages.each do |msg|
          format.js { flash[:alert] = msg }
        end
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
    @image = current_user.images.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:name, :file, :file_cache, :search, :sort_by, :keywords, :imageid)
  end

  def remove_current_tags(image)
    tags = image.tags
    tags.each do |tag|
      image_tag = current_user.image_tags.where(tag_id: tag.id, image_id: image.id)[0]
      image_tag&.destroy
    end
  end
end
