# frozen_string_literal: true

class LogController < ApplicationController
  def index
    @log = Log.sorted
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
end
