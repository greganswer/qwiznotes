class HomeController < ApplicationController
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      @notes = current_user.notes.recently_updated
        .page(params[:page]).per(params[:per_page])
    end
  end
end
