# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :auth_user

  def auth_user
    header = request.header['auth']
    header = header.split(' ').last if header

    begin
      @decoded      = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def check_if_user_is_authenticated
    deny_message if @current_user.nil?
  end

  def deny_message
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end

  def not_authenticated_user_message
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end
