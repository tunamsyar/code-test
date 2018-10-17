class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def index
    render json: User.all, status: :ok
  end

  def create
    user = User.new(user_params)
    return render_error(user.errors.messages, :bad_request) unless user.save
    render json: user, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :country)
  end
end
