class ReturnController < ApplicationController

    before_action :confirmed_logged_in
    before_action :user_has_permissions
    layout :get_user_layout

    def index
        @checkout = Checkout.find(params[:id])
        @item = Item.find(@checkout.item_id)
        if @item.merch == 'Yes'
            redirect_to controller: 'return', action: 'index_merch', id: params[:id]
        end
    end

    def submit
        @checkout = Checkout.find(params[:id])

        if (params[:return_amount].to_i > @checkout.amount)
            flash[:notice] = "You don't have enough items."
            redirect_to({:action => 'index', :id => @checkout.id})
        else
            @item = Item.find(@checkout.item_id)
            @user = User.find(@checkout.user_id)

            @item.avail_stock = @item.avail_stock+(params[:return_amount].to_i)

            if (params[:return_amount].to_i == @checkout.amount)
                @user.item_ids.delete(@item.id)
                @user.save

                @checkout.destroy
            else
                @checkout.amount = @checkout.amount-(params[:return_amount].to_i)
            end
            
            if @item.merch == 'Yes'
                @item.total_stock = @item.total_stock + (params[:return_amount].to_i)
                if (params[:sold].to_i == @checkout.amount)
                    @user.item_ids.delete(@item.id)
                    @user.save
                else
                    @checkout.amount = @checkout.amount-(params[:sold].to_i)
                end
            end
            @item.save
            @checkout.save
            
            flash[:notice] = "Item returned successfully."
            redirect_to(checkout_myItems_path)
        end
    end
    def index_merch
        @checkout = Checkout.find(params[:id])
        @item = Item.find(@checkout.item_id)
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
