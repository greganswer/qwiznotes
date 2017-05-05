class NotesController < ApplicationController
  before_action :set_note, {
    only: %i(show edit update destroy review quiz quiz_results)
  }
  skip_before_action :authenticate_user!, {
    only: %i(index show quiz quiz_results review)
  }

  #
  # Get methods
  #

  def index
    @notes = NotesFilter.new(params: params, cookies: cookies).call
    render "index_template", locals: { records: @notes, card_size: :medium }
  end

  def new
    @note = Note.new
    authorize @note
  end

  def show
  end

  def edit
  end

  def review
  end

  def quiz
  end

  def autocomplete
    @note = Note.new
    authorize @note
    suggestions = Note.search(params[:q], {
        suggest: true,
        fields: [{ title: :word_middle }],
        limit: 10,
        aggs: [:title],
      })
    suggestions = suggestions.aggs['title']['buckets']
    render json: { suggestions: suggestions.map { |item| item['key'] } }
  end


  #
  # Post methods
  #

  def create
    @note = current_user.notes.build(note_params)
    authorize @note
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: t('note.created') }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def quiz_results
    unless request.post? && params[:user_answers].present?
      return redirect_to [:quiz, @note], alert: t("quiz.not_taken")
    end
    @note.quiz_results(params[:quiz], params[:user_answers])
  end

  #
  # Patch/put methods
  #

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: t('note.updated') }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Delete methods
  #

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: t('note.deleted') }
      format.json { head :no_content }
    end
  end

  #
  # Private
  #

  private

  def set_note
    @note = Note.find_using_hashid(params[:id])
      authorize @note
      set_recently_viewed_notes
  end

  def set_recently_viewed_notes
    cookies.permanent[:recently_viewed_notes] ||= ""
    cookie_as_array = cookies.permanent[:recently_viewed_notes].split(',')
    return if !request.get? || request.xhr?
    return if cookie_as_array.last == @note.id.to_s
    cookie_as_array.delete_at(0) if cookie_as_array.size >= 3
    cookie_as_array << @note.id
    cookies.permanent[:recently_viewed_notes] = cookie_as_array.join(',')
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
