class Admin::UsersController <ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = Devise.friendly_token[0, 20] 
    
    if @user.save
      @user.send_reset_password_instructions
      redirect_to admin_users_path, notice: 'User was successfully created. An email has been sent to set up their password.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end

  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user&.admin?
  end
end
