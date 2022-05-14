class FeedsController < ApplicationController
  # GET /feeds/1
  def show
    user_id = params[:id]

    render json: {error: "not-found"}.to_json, status: 404 unless User.exists?(user_id)

    @feeds = FeedFetchService.new(user_id: user_id).latest
  end

end
