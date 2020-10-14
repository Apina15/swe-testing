class CheckoutController < ApplicationController

    before_action :confirmed_logged_in
    before_action :user_has_permissions

    def index
        @item = Item.find(params[:id])
    end

    def show
        @checkout = Checkout.find(params[:id])
    end

    def myitem_show
        @checkout = Checkout.find(params[:id])
    end

    def showAll
        @checkouts = Checkout.all
        if (params[:sort_type] != nil)
            @sort_type = params[:sort_type]
            @sort_dir = params[:sort_dir]
            if @sort_type == 'Item Name'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.item.name }
            elsif @sort_type == 'Person'
                @checkouts_sorted = @checkouts.sort_by { |checkout| [checkout.user.first_name, checkout.user.last_name] }
            elsif @sort_type == 'Checkout Reason'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.checkout_reason }
            elsif @sort_type == 'Checkout Date'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.updated_at.in_time_zone('America/Chicago').strftime('%I:%M:%S %p') }
            elsif @sort_type == 'Amount'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.amount }
            end

            if @sort_dir == 'Z -> A'
                @checkouts_sorted = @checkouts_sorted.reverse
            end
        else
            @sort_type = 'Checkout Date'
            @sort_dir = 'A -> Z'
            @checkouts_sorted = @checkouts
        end
    end

    def myItems
        @checkouts = Checkout.where(user_id: session[:user_id])
        if (params[:sort_type] != nil)
            @sort_type = params[:sort_type]
            @sort_dir = params[:sort_dir]
            if @sort_type == 'Item Name'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.item.name }
            elsif @sort_type == 'Person'
                @checkouts_sorted = @checkouts.sort_by { |checkout| [checkout.user.first_name, checkout.user.last_name] }
            elsif @sort_type == 'Checkout Reason'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.checkout_reason }
            elsif @sort_type == 'Checkout Date'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.updated_at.in_time_zone('America/Chicago').strftime('%I:%M:%S %p') }
            elsif @sort_type == 'Amount'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.amount }
            end

            if @sort_dir == 'Z -> A'
                @checkouts_sorted = @checkouts_sorted.reverse
            end

        else
            @sort_type = 'Checkout Date'
            @sort_dir = 'A -> Z'
            @checkouts_sorted = @checkouts
        end
    end

    def showAllUserItems
        @checkouts = Checkout.where(user_id: params[:id])
        @user = User.find(params[:id])
        if (params[:sort_type] != nil)
            @sort_type = params[:sort_type]
            @sort_dir = params[:sort_dir]
            if @sort_type == 'Item Name'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.item.name }
            elsif @sort_type == 'Person'
                @checkouts_sorted = @checkouts.sort_by { |checkout| [checkout.user.first_name, checkout.user.last_name] }
            elsif @sort_type == 'Checkout Reason'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.checkout_reason }
            elsif @sort_type == 'Checkout Date'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.updated_at.in_time_zone('America/Chicago').strftime('%I:%M:%S %p') }
            elsif @sort_type == 'Amount'
                @checkouts_sorted = @checkouts.sort_by { |checkout| checkout.amount }
            end

            if @sort_dir == 'Z -> A'
                @checkouts_sorted = @checkouts_sorted.reverse
            end

        else
            @sort_type = 'Checkout Date'
            @sort_dir = 'A -> Z'
            @checkouts_sorted = @checkouts
        end
    end

    def submit
        @item = Item.find(params[:id])
        @user = User.find(params[:uid])

        if (params[:checkout_amount].to_i > @item.avail_stock)
            flash[:notice] = "Insufficient inventory."
            redirect_to({:action => 'index', :id => @item.id})
        else
                
            @item.avail_stock = @item.avail_stock-(params[:checkout_amount].to_i)
            if @item.merch == 'Yes'
                @item.total_stock = @item.total_stock - (params[:checkout_amount].to_i)
            end
            @item.save

            @user.item_ids.append(@item.id)
            @user.save

            @checkout = Checkout.new
            @checkout.user_id = @user.id
            @checkout.item_id = @item.id
            @checkout.amount = params[:checkout_amount].to_i
            @checkout.checkout_reason = params[:reason]
            @checkout.save
            flash[:notice] = "Item checked out."
            redirect_to({:controller => 'items', :action => 'index'})
        end
    end
end
