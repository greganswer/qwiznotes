class DemoController < ApplicationController
  before_action :set_note, except: :reload
  before_action :skip_authorization
  skip_before_action :authenticate_user!

  def index
    render "notes/new"
  end

  def reload
    set_cookie_defaults
    redirect_to demo_path
  end

  def review
    render "notes/review"
  end

  def quiz
    render "notes/quiz"
  end

  def quiz_results
    unless request.post? && params[:user_answers].present?
      return redirect_to demo_quiz_path, alert: t("quiz.not_taken")
    end
    @note.quiz_results(params[:quiz], params[:user_answers])
    render "notes/quiz_results"
  end

  #
  # Private
  #

  private

  def set_cookie_defaults
    defaults = { title: t("note.sample.title"), content: t("note.sample.content") }
    cookies[:demo_note] = defaults.to_json
  end

  # Set or retrieve the note attributes from the cookie then set the note with default attributes.
  # Check if the user submitted any input then put the note attributes in a cookie.
  #
  def set_note
    set_cookie_defaults unless cookies[:demo_note].present?
    params[:note] ||= JSON.parse(cookies[:demo_note])
    title = params[:note].try(:[], "title") ? html_clean(params[:note][:title]) : t("note.sample.title")
    content = params[:note].try(:[], "content") ? html_clean(params[:note][:content]) : t("note.sample.content")

    @note = Note.new(title: title, content: content)
    unless @note.has_minimum_number_of_concepts?
      @note.content = t("note.sample.content")
      flash[:not_enough_pairs] = true
    end
    @note.prepare_inputs
    cookies.permanent[:demo_note] = @note.attributes.slice("title", "content").to_json
  end
end
