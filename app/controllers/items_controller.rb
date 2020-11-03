class ItemsController < ApplicationController

  before_action :confirmed_logged_in
  before_action :user_has_permissions
  layout :get_user_layout

  def index
    @items = Item.all
    if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
      @items_name = Item.where(name: params[:search_tag])
      @items_desc = Item.where(description: params[:search_tag])
      @items_total = Item.where(total_stock: params[:search_tag])
      @items_avail = Item.where(avail_stock: params[:search_tag])
      @items_merch = Item.where(merch: params[:search_tag])
      @items_sorted = [].concat(@items_name)
                        .concat(@items_desc)
                        .concat(@items_total)
                        .concat(@items_avail)
                        .concat(@items_merch)
      @items_sorted = @items_sorted.uniq
      @items_sorted = @items_sorted.sort_by { |item| item.name }
    elsif (params[:sort_type] != nil)
      @sort_type = params[:sort_type]
      @sort_dir = params[:sort_dir]
      if @sort_type == 'Name'
        @items_sorted = @items.sort_by { |item| item.name }
      elsif @sort_type == 'Description'
        @items_sorted = @items.sort_by { |item| item.description }
      elsif @sort_type == 'Total Stock'
        @items_sorted = @items.sort_by { |item| item.total_stock }
      elsif @sort_type == 'Available Stock'
        @items_sorted = @items.sort_by { |item| item.avail_stock }
      elsif @sort_type == 'Merch'
        @items_sorted = @items.sort_by { |item| item.merch }
      end

      if @sort_dir == 'Z -> A'
        @items_sorted = @items_sorted.reverse
      end

    else
      @sort_type = 'Name'
      @sort_dir = 'A -> Z'
      @items_sorted = @items.sort_by { |item| item.name }
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(subject_params)
    if @item.save
      redirect_to(items_path)
    else
      out = ''
      @item.errors.full_messages.each do |msg|
        out = out + ' ' + msg
      end
      render('new')
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(subject_params)
      redirect_to(item_path(@item))
    else
      out = ''
      @item.errors.full_messages.each do |msg|
        out = out + ' ' + msg
      end
      render('edit')
    end
  end

  def delete
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to(items_path)
  end

  private

  def subject_params
    params.require(:item).permit(:name, :description, :total_stock, :avail_stock, :location, :merch)
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
