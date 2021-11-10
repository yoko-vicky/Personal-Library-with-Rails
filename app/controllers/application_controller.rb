class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :file_size

  def file_size(image)
    (image.file.size / 1000).floor(1)
  end
end
