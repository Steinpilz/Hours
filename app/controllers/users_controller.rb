include TimeSeriesInitializer

class UsersController < ApplicationController
  def show
    authorize resource
    @time_series = time_series_for(resource)
  end

  def index
    @users = policy_scope(User)
  end

  def edit
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user
    if @user.update_with_password(user_params)
      redirect_to edit_user_path, notice: t(:user_updated)
    else
      render :edit
    end
  end

  private

  def resource
    @user ||= User.find_by_slug(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :current_password)
  end
end
