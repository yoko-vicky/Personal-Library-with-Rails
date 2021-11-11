class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]

  # GET /tags or /tags.json
  def index
    @tags = Tag.all.page(params[:page]).per(10)
  end

  # GET /tags/1 or /tags/1.json
  def show
    @tag_images = @tag.images.page(params[:page]).per(10)
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit; end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      flash[:notice] = 'Tag was successfully created.'
      redirect_to tag_path(@tag)
    else
      # @tag.errors
      flash[:alert] = 'Something is wrong'
      render 'new'
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    if @tag.update(tag_params)
      flash[:notice] = 'Tag was successfully updated.'
      redirect_to tag_path(@tag)
    else
      flash[:alert] = 'Something is wrong'
      render 'edit'
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy
    flash[:notice] = 'Tag was successfully deleted.'
    redirect_to tags_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end
end
