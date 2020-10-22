class UsersController < ApplicationController

    before_action :confirmed_logged_in, :except => [:new, :create]
    before_action :user_is_admin, :except => [:new, :create]

  def index
    @users = User.all
    if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
      @users_first_name = User.where(first_name: params[:search_tag])
      @users_last_name = User.where(last_name: params[:search_tag])
      @users_permissions = User.where(permissions: params[:search_tag])
      @users_sorted = [].concat(@users_first_name).concat(@users_last_name).concat(@users_permissions)
      @users_sorted = @users_sorted.uniq
    elsif (params[:sort_type] != nil)
        @sort_type = params[:sort_type]
        @sort_dir = params[:sort_dir]
        if @sort_type == 'First Name'
          @users_sorted = @users.sort_by { |user| user.first_name }
        elsif @sort_type == 'Last Name'
          @users_sorted = @users.sort_by { |user| user.last_name }
        elsif @sort_type == 'Permissions'
          @users_sorted = @users.sort_by { |user| user.permissions }
        elsif @sort_type == 'Amount of Rented Items'
          @users_sorted = @users.sort_by { |user| user.item_ids.length }
        end

        if @sort_dir == 'Z -> A'
          @users_sorted = @users_sorted.reverse
        end

    else
        @sort_type = 'First Name'
        @sort_dir = 'A -> Z'
        @users_sorted = @users
    end
  end

  def new
      @user = User.new
  end

  def create
    @admins = User.where(:permissions=>2)
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      @admins.each do |admin|
        UserMailer.with(user: @user, admin: admin).admin_approval_email.deliver_now
      end
      flash[:notice] = 'Account Created. You will receive an e-mail shortly. Please await authorization before using the site.'
      redirect_to(access_login_path)
    else
      flash[:errors] = @user.errors.full_messages
      render('new')
    end
  end

  def edit
      @user = User.find(params[:id])
  end

  def show
      @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @perm = @user.permissions
    if @user.update_attributes(user_params)
      if @user.permissions > @perm
        UserMailer.with(user: @user).authorized_email.deliver_now
        flash[:notice] = "Authorization notification e-mail sent to #{@user.name} at #{@user.email}"
        redirect_to(users_path)
      else
      flash[:notice] = 'User account updated successfully.'
      redirect_to(users_path)
      end
    else
      render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "The User has been removed."
    redirect_to(users_path)
  end

  def will_checkout_or_return_key
    @user = User.find_by_id(session[:user_id])
  end

  def checkout_or_return_key
    @user = User.find_by_id(session[:user_id])
    #@user = User.find(params[:id])
    if params[:commit] == 'Checkout Key'
      if @user.hasKey == 0
        User.update(session[:user_id], :hasKey => 1)
        flash[:notice] = "You checked out a key!"
      elsif @user.hasKey == 1
        flash[:notice] = "You already have a key checked out!"
      end
    elsif params[:commit] == 'Return Key'
      if @user.hasKey == 1
        User.update(session[:user_id], :hasKey => 0)
        flash[:notice] = "You returned a key!"
      elsif @user.hasKey == 0
        flash[:notice] = "You have no key to return!"
      end
    end
    redirect_to(access_menu_path)
  end

  def manage
    @user = User.find_by_id(session[:user_id])
  end

  def manage_update
    @user = User.find_by_id(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'Account details updated successfully.'
      redirect_to(access_menu_path)
    end
  end

  private

  def user_params
    # Permit :password, but NOT :password_digest
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :permissions,
      :password
    )
  end

end
