class HomeController < ApplicationController
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      @notes = current_user.notes.recently_updated
        .page(params[:page]).per(params[:per_page])
      render "index_template", locals: { records: @notes }
    end
  end

  def help
    @contact = ContactForm.new(contact_params)
    if request.post?
      @contact.request = request
      if @contact.deliver
        return redirect_to :back, notice: t("contact.message_sent")
      else
        flash.now[:notice] = t("contact.message_not_sent") unless @contact.errors.any?
      end
    end
  end

  #
  # Private
  #

  private

  def contact_params
    if request.post?
      params[:contact_form]
    elsif request.get?
      { email: current_user&.email }
    else
      {}
    end
  end
end
