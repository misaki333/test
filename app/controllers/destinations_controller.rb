class DestinationsController < ApplicationController
  def spots_select
    if request.xhr?
      render partial: 'spots', locals: {category_id: params[:category_id]}
    end
  end

  def new
    @destination = Destination.new
  end
end
