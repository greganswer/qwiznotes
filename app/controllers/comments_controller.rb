class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_commentable

  #
  # Get methods
  #

  def show
    page = (@commentable.comments.count / Kaminari.config.default_per_page) + 1
    redirect_to [@commentable, page: page, anchor: "comment_#{@comment.id}"]
  end

  #
  # Post methods
  #

  def create
    @comment = @commentable.try(:comments).try(:build, comment_params)
    authorize @comment
    if @comment.try(:save)
      redirect_to @comment, notice: t("comment.created")
    else
      redirect_to :back, notice: t("comment.not_created")
    end
  end

  #
  # Patch methods
  #

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # Delete methods
  #

  def destroy
    @comment.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  #
  # Private
  #

  private

  def set_comment
    @comment = Comment.find_using_hashid(params[:id])
    authorize @comment
  end

  def set_commentable
    @commentable ||= Note.find_using_hashid(params[:note_id]) if params[:note_id]
    @commentable ||= @comment&.item
  end

  def comment_params
    params.require(:comment).permit(%i(content)).merge(user: current_user)
  end
end
