class NotesController < ApplicationController
  before_action :set_note, only: %i(show edit update destroy review quiz quiz_results)

  #
  # Get methods
  #

  def index
    @notes = Note.recently_updated.page(params[:page]).per(params[:per_page])
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def review
  end

  def quiz
  end

  def quiz_results
    unless request.post? && params[:user_answers].present?
      return redirect_to [:quiz, @note], alert: t("quiz.not_taken")
    end
    @note.quiz_results(params[:quiz], params[:user_answers])
  end

  #
  # Post methods
  #

  def create
    @note = current_user.notes.build(note_params)
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

  private

  def set_note
    @note = Note.find_by_hashid(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
