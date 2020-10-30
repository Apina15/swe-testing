# frozen_string_literal: true

class LogController < ApplicationController
  layout :get_user_layout

  def index
    user = User.find(session[:user_id])
    if (user.permissions < 2)
      @log = Log.where(:requestor_email => user.email)
    else
      @log = Log.sorted
    end
    @logs = Log.all
    respond_to do |format|
      format.xlsx do
        response.headers[
          'Content-Disposition'
            ] = 'attachment; filename= HistoryOfCheckOutItems.xlsx'
      end
      format.html { render :index }
    end
  end

  def log_params
    params.require(:log).permit(:requestor_name, :requestor_email, :type_, :item_name, :item_quantity, :check_in)
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
