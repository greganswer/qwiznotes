class HomeController < ApplicationController
  def index
    @notes = current_user.notes.recently_updated if user_signed_in?
  end
end
