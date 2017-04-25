class UsersController < ApplicationController
  def index
    @users = User.by_name.page(params[:page]).per(params[:per_page])
    render "index_template", locals: { records: @users, has_new_button: false, date_columns: %i(created_at) }
  end

  def show
    @user = User.find_using_hashid(params[:id])
    authorize @user
  end
end
