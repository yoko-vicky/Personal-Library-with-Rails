class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy]

  URL = 'https://api.clarifai.com/v2/models/9f54c0342741574068ec696ddbebd699/outputs'.freeze
  HEADERS = {
    Accept: 'application/json',
    Authorization: 'Key ' + ENV['CLARIFY_ACCESS_TOKEN']
  }.freeze

  private_constant :URL, :HEADERS

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
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
        # here it should have tagging(@image)
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
    @image = current_user.images.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:name, :file, :file_cache, :search, :sort_by)
  end

  def tagging(image)
    @keywords = []
    # 1. Based on the image file url of the S3(@image.file), send a request to Clarifi, retrive taggings as an array
    get_keywords(URL, create_body(image.file), HEADERS)
    create_add_tag(@keywords)
  end

  def create_add_tag(keywords)
    # 2. Create each Tag based on taggings array
    keywords.each do |keyword|
      tag_exists = Tag.names_downcased.include?(keyword.downcase)
      tag = tag_exists ? Tag.find_by(name: keyword.downcase) : current_user.tags.new(name: keyword)
      # 3. Make a connection by posting ImageTag row to ImageTag through table
      ImageTag.create(image_id: @image.id, tag_id: tag.id)
    end
  end

  def get_keywords(url, body, headers)
    response = Faraday.post(url, body, headers)
    return [] unless response.status == 200

    regions = JSON.parse(response.body, symbolize_names: true)[:outputs][0][:data][:regions]
    @keywords << regions.map { |item| item[:data][:concepts][0][:name] }.uniq!
  end

  def create_body(image_url)
    {
      user_app_id: {
        user_id: ENV['CLARIFY_USER_ID'],
        app_id: ENV['CLARIFY_APP_ID']
      },
      inputs: [
        {
          data: {
            image: {
              url: image_url
            }
          }
        }
      ]
    }.to_json
  end
end
