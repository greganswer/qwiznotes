class HomeController < ApplicationController
  def index
    @notes = current_user.notes.recently_updated.page(params[:page]).per(params[:per_page]) if user_signed_in?
  end
end
