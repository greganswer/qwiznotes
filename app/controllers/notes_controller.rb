class NotesController < ApplicationController
  before_action :set_note, only: %i(show edit update destroy review quiz quiz_results)

  # GET

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
    return unless @note
    if !request.post? || params[:user_answers].blank?
      link = url_for[/demo/] ? [:demo, :quiz] : [:quiz, @note]
      return redirect_to link, danger: t("records.quizzes.not_taken")
    end
    @quiz = @note.quiz_results(
      quiz_input: JSON[params[:quiz]].with_indifferent_access,
      user_answers: params[:user_answers],
    )
  end

  # POST

  def create
    @note = current_user.notes.build(note_params)
    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: t('.success') }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: t('.success') }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_note
    @note = Note.find(hashid_decode(params[:id]))
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
