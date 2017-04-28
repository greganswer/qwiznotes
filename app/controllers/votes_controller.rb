class VotesController < ApplicationController
  before_action :set_votable

  #
  # Get methods
  #

  def show
    redirect_to @votable
  end

  #
  # Post methods
  #

  def create
    @vote = @votable.try(:votes).try(:where, user_id: current_user.id).try(:first_or_initialize)
    authorize @vote

    respond_to do |format|
      if @vote.try(:save)
        @votable.reload
        format.html { redirect_to @votable, notice: t("vote.created", item: item_name) }
        format.js
      else
        format.html { redirect_to :back, notice: t("vote.not_created", item: item_name) }
        format.js
      end
    end
  end

  #
  # Delete methods
  #

  def destroy
    @votes = @votable.try(:votes).try(:where, user_id: current_user.id)
    @vote = @votes.try(:first)
    authorize @vote

    respond_to do |format|
      if @votes.try(:destroy_all)
        @votable.reload
        format.html { redirect_to @votable, notice: t("vote.created", item: item_name) }
        format.js
      else
        format.html { redirect_to :back, notice: t("vote.not_created", item: item_name) }
        format.js
      end
    end
  end

  #
  # Private
  #

  private

  def item_name
    @votable.model_name.human.downcase
  end

  def set_votable
    @votable ||= Note.find_using_hashid(params[:note_id]) if params[:note_id]
    @votable ||= @vote&.item
  end
end
