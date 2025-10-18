class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def sign_up # same as create
    user = User.new(**user_params)

    if user.save!
      render json: user, status: :created
    else
      render json: user.errors.full_message, status: :unprocessable_entity
    end
  end

  def auth
    user = User.find_by(email: user_params[:email])

    if user.present?
      auth_user(user: user, password: user_params[:password])
    else
      not_authenticated_user_message
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :role, :password)
  end
end
