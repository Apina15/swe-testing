class ApplicationController < ActionController::Base
    
    private
    
    def confirmed_logged_in
        unless session[:user_id]
            flash[:notice] = "Please log in."
            redirect_to(access_login_path)
        end
    end

    def user_has_permissions
        permissions = User.find(session[:user_id]).permissions
        unless permissions > 0
            flash[:notice] = "Account not yet authorized."
            redirect_to(access_unauthorized_path)
        end
    end

    def user_is_admin
        permissions = User.find(session[:user_id]).permissions
        unless permissions == 2
            flash[:notice] = "Access restricted to administrator."
            redirect_to(access_user_menu_url)
        end
    end
    
end
