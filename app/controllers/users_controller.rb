class UsersController < ApplicationController
  def show
    if params[:id] == ME_IDENTIFIER
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    authorize current_user, policy_class: UserPolicy

    @user = current_user
  end

  def update
    authorize current_user, policy_class: UserPolicy

    @user = current_user

    ::Users::Update.new
                   .with_step_args(update_user: [ user: @user ], validate: [ user: @user ])
                   .call(params[:user].to_unsafe_h) do |on|
      on.success do |result|
        redirect_to user_path(@user), notice: t(".success")
      end

      on.failure do |result|
        @errors = result

        render :edit, status: :unprocessable_entity
      end
    end
  end
end
