# frozen_string_literal: true

class UsersController < ApplicationController
  before_action      :set_user, only: [:show]
  skip_before_action :login

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  # same as create
  def sign_up
    user = User.new(**user_params)

    if user.save!
      render json: user, status: :created
    else
      render json: user.errors.full_message, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: user_params[:email])

    if user.present? && user.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: { token: token }, status: :ok
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
