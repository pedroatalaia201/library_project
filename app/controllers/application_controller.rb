class ApplicationController < ActionController::API
  private

  def auth_user(user:, password:)
    if user.authenticate(password)
      @sys_user = user
      render json: user, status: :ok
    else
      not_authenticated_user_message
    end
  end

  # Need to set the geme jwt first...
  def check_if_user_is_authenticated
    deny_message if @sys_user.nil?
  end

  def deny_message
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end

  def not_authenticated_user_message
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end
