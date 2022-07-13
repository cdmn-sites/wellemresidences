class ImagesController < ApplicationController

  def show
    blob = ActiveStorage::Blob.find_signed(params[:id])
    redirect_to url_for(blob.variant(resize_to_limit: [1920, 1200]))
  end
end