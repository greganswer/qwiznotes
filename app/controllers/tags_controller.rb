class TagsController < ApplicationController
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  def autocomplete
    render json: ActsAsTaggableOn::Tag.where("name ILIKE ?", "%#{params[:q]}%").limit(10).pluck(:name)
  end
end
