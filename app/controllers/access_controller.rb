class AccessController < ApplicationController
    
    
  before_action :confirmed_logged_in, :except => [:login, :attempt_login, :logout]
  before_action :user_has_permissions, :except => [:unauthorized, :login, :attempt_login, :logout]
  
  def menu
    @user = User.find_by_id(session[:user_id])
    if @user.permissions == 1
        redirect_to(access_user_menu_path)
    end
  end
  
  def user_menu
    @user = User.find_by_id(session[:user_id])
  end

  def login
      
  end
  
  def attempt_login
    if params[:email].present? && params[:password].present?
        found_user = User.where(:email => params[:email]).first
        if found_user
            authorized_user = found_user.authenticate(params[:password])
        end
    end
      
    if authorized_user
        session[:user_id] = authorized_user.id
        if authorized_user.permissions == 2
            flash[:notice] = "Logged in."
            redirect_to(access_menu_path)
        else
          authorized_user.permissions == 1
          flash[:notice] = "Logged in."
          redirect_to(access_user_menu_path)
        end
    else
        flash.now[:notice] = "Invalid username or password."
        render('login')
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "logged out."
    redirect_to(access_login_path)
  end

  def unauthorized
    @user = User.find_by_id(session[:user_id])
  end

end

