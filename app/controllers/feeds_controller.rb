class FeedsController < ApplicationController
  # GET /feeds/1
  def show
    @feeds = Feed.includes(:creator, :post).where(user_id: params[:id]).limit(10)
  end

end
