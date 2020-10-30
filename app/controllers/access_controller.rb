class AccessController < ApplicationController
    
  before_action :confirmed_logged_in, :except => [:login, :attempt_login, :logout]
  before_action :user_has_permissions, :except => [:unauthorized, :login, :attempt_login, :logout]

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
        if authorized_user.permissions > 0
            redirect_to(items_path)
        end
    else
        flash.now[:notice] = "Invalid username or password."
        render('login')
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to(access_login_path)
  end

  def unauthorized
    @user = User.find_by_id(session[:user_id])
  end

  def get_user_layout
    permissions = User.find(session[:user_id]).permissions
    if permissions == 2
        "admin"
    elsif permissions == 1
        "user"
    end
  end


end

