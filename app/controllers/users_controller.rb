class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users/1
  def show
    @events = @user.events.where(state: :confirmed)
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      if params[:remove_avatar]
        @user.remove_avatar!
        @user.save
      end
      redirect_to @user, notice: 'User was successfully updated.'
    else
      flash.now[:error] = "An error prohibited your Profile from being saved: #{@user.errors.full_messages.join('. ')}."
      render :edit
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :biography, :nickname, :affiliation, :avatar, :remove_avatar, :title, :mobile)
    end
end
