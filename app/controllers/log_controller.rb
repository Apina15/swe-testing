# frozen_string_literal: true

class LogController < ApplicationController
  layout :get_user_layout

  def index
    user = User.find(session[:user_id])
    if (user.permissions < 2)
      @log = Log.where(:requestor_email => user.email).sorted
      if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
        @log_person = Log.where(requestor_name: params[:search_tag])
        @log_item = Log.where(item_name: params[:search_tag])
        @log_amount = Log.where(item_quantity: params[:search_tag])
        @log_event = Log.where(event: params[:search_tag])
        @log_created = Log.where(created_at: params[:search_tag])
        @log_status = Log.where(type_: params[:search_tag])
        @log_sorted = [].concat(@log_person)
                        .concat(@log_item)
                        .concat(@log_amount)
                        .concat(@log_event)
                        .concat(@log_created)
                        .concat(@log_status)
        @log_sorted = @log_sorted.uniq
      elsif (params[:sort_type] != nil)
        @sort_type = params[:sort_type]
        @sort_dir = params[:sort_dir]
        if @sort_type == 'Person'
          @log_sorted = @log.sort_by { |log| log.requestor_name }
        elsif @sort_type == 'Email'
          @log_sorted = @log.sort_by { |log| log.requestor_email }
        elsif @sort_type == 'Item Name'
          @log_sorted = @log.sort_by { |log| log.item_name }
        elsif @sort_type == 'Item Amount'
          @log_sorted = @log.sort_by { |log| log.item_quantity }
        elsif @sort_type == 'Event'
          @log_sorted = @log.sort_by { |log| log.event }
        elsif @sort_type == 'Check in Date'
          @log_sorted = @log.sort_by { |log| log.check_in }
        elsif @sort_type == 'Status'
          @log_sorted = @log.sort_by { |log| log.type_ }
        end

        if @sort_dir == 'Z -> A'
          @log_sorted = @log_sorted.reverse
        end
      else
        @sort_type = 'Check in Date'
        @sort_dir = 'A -> Z'
        @log_sorted = @log
      end
    else
      @log = Log.sorted
      if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
        @log_person = Log.where(requestor_name: params[:search_tag])
        @log_item = Log.where(item_name: params[:search_tag])
        @log_amount = Log.where(item_quantity: params[:search_tag])
        @log_event = Log.where(event: params[:search_tag])
        @log_created = Log.where(created_at: params[:search_tag])
        @log_status = Log.where(type_: params[:search_tag])
        @log_sorted = [].concat(@log_person)
                        .concat(@log_item)
                        .concat(@log_amount)
                        .concat(@log_event)
                        .concat(@log_created)
                        .concat(@log_status)
        @log_sorted = @log_sorted.uniq
      elsif (params[:sort_type] != nil)
        @sort_type = params[:sort_type]
        @sort_dir = params[:sort_dir]
        if @sort_type == 'Person'
          @log_sorted = @log.sort_by { |log| log.requestor_name }
        elsif @sort_type == 'Email'
          @log_sorted = @log.sort_by { |log| log.requestor_email }
        elsif @sort_type == 'Item Name'
          @log_sorted = @log.sort_by { |log| log.item_name }
        elsif @sort_type == 'Item Amount'
          @log_sorted = @log.sort_by { |log| log.item_quantity }
        elsif @sort_type == 'Event'
          @log_sorted = @log.sort_by { |log| log.event }
        elsif @sort_type == 'Check in Date'
          @log_sorted = @log.sort_by { |log| log.check_in }
        elsif @sort_type == 'Status'
          @log_sorted = @log.sort_by { |log| log.type_ }
        end

        if @sort_dir == 'Z -> A'
          @log_sorted = @log_sorted.reverse
        end
      else
        @sort_type = 'Check in Date'
        @sort_dir = 'A -> Z'
        @log_sorted = @log
      end
    end

    @logs = @log_sorted
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
