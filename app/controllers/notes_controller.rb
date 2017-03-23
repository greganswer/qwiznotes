class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET

  def index
    @notes = Note.order('updated_at DESC').page(params[:page]).per(params[:per_page])
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  # POST

  def create
    @note = Note.new(note_params)

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
