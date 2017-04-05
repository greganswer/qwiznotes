class LegalController < ApplicationController
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  def privacy
  end

  def terms
  end
end
