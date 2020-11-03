# frozen_string_literal: true

# found article going over how to use regular expressions to validate email addresses entered into the form
# link to article: https://blog.mailtrap.io/rails-email-validation/
# more work can be done to better validate email addresses
REGEX_PATTERN = /^(.+)@(.+)$/.freeze

class TransactionsController < ApplicationController
#  before_action :authorize, only: %i[create edit update delete destroy show new index]
  layout :get_user_layout

  def index
    user = User.find(session[:user_id])
    if (user.permissions < 2)
      @transactions = Transaction.where(:requestor_email => user.email).sorted
      if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
        @transactions_person = Transaction.where(requestor_name: params[:search_tag])
        @transactions_item = Transaction.where(item_name: params[:search_tag])
        @transactions_amount = Transaction.where(item_quantity: params[:search_tag])
        @transactions_event = Transaction.where(event: params[:search_tag])
        @transactions_created = Transaction.where(created_at: params[:search_tag])
        @transactions_status = Transaction.where(type_: params[:search_tag])
        @transactions_sorted = [].concat(@transactions_person)
                                  .concat(@transactions_item)
                                  .concat(@transactions_amount)
                                  .concat(@transactions_event)
                                  .concat(@transactions_created)
                                  .concat(@transactions_status)
        @transactions_sorted = @transactions_sorted.uniq
      elsif (params[:sort_type] != nil)
          @sort_type = params[:sort_type]
          @sort_dir = params[:sort_dir]
          if @sort_type == 'Person'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.requestor_name }
          elsif @sort_type == 'Item Name'
              @transactions_sorted = @transactions.sort_by { |transaction| [transaction.item_name] }
          elsif @sort_type == 'Item Amount'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.item_quantity }
          elsif @sort_type == 'Event'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.event }
          elsif @sort_type == 'Checkout Date'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.created_at }
            elsif @sort_type == 'Status'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.type_ }
          end

          if @sort_dir == 'Z -> A'
              @transactions_sorted = @transactions_sorted.reverse
          end
      else
          @sort_type = 'Checkout Date'
          @sort_dir = 'A -> Z'
          @transactions_sorted = @transactions
      end
    else
      @transactions = Transaction.sorted
      if ((params[:search_tag] != nil) && (params[:search_tag] != ""))
        @transactions_person = Transaction.where(requestor_name: params[:search_tag])
        @transactions_item = Transaction.where(item_name: params[:search_tag])
        @transactions_amount = Transaction.where(item_quantity: params[:search_tag])
        @transactions_event = Transaction.where(event: params[:search_tag])
        @transactions_created = Transaction.where(created_at: params[:search_tag])
        @transactions_status = Transaction.where(type_: params[:search_tag])
        @transactions_sorted = [].concat(@transactions_person)
                                  .concat(@transactions_item)
                                  .concat(@transactions_amount)
                                  .concat(@transactions_event)
                                  .concat(@transactions_created)
                                  .concat(@transactions_status)
        @transactions_sorted = @transactions_sorted.uniq
      elsif (params[:sort_type] != nil)
        @sort_type = params[:sort_type]
        @sort_dir = params[:sort_dir]
        if @sort_type == 'Person'
            @transactions_sorted = @transactions.sort_by { |transaction| transaction.requestor_name }
        elsif @sort_type == 'Item Name'
            @transactions_sorted = @transactions.sort_by { |transaction| [transaction.item_name] }
        elsif @sort_type == 'Item Amount'
            @transactions_sorted = @transactions.sort_by { |transaction| transaction.item_quantity }
        elsif @sort_type == 'Event'
            @transactions_sorted = @transactions.sort_by { |transaction| transaction.event }
        elsif @sort_type == 'Checkout Date'
            @transactions_sorted = @transactions.sort_by { |transaction| transaction.created_at }
          elsif @sort_type == 'Status'
            @transactions_sorted = @transactions.sort_by { |transaction| transaction.type_ }
        end

        if @sort_dir == 'Z -> A'
            @transactions_sorted = @transactions_sorted.reverse
        end
      else
          @sort_type = 'Checkout Date'
          @sort_dir = 'A -> Z'
          @transactions_sorted = @transactions
      end
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    #@log = Log.new
  end

#doesn't end up being used
  def create
    @transaction = Transaction.new(transaction_params) # need to find out how to set the 2 week immediately
    @transaction.type_ = 'Checked Out'
    remind_date = Time.now + (2 * 7 * 24 * 60 * 60) # get the time current time and set it to two weeks later
    @transaction.remind_date = remind_date # might need to format this
    # @transaction.user_id = session[:user_id]

    @log = Log.new
    @log.id = @transaction.id
    @log.requestor_name = @transaction.requestor_name
    @log.requestor_email = @transaction.requestor_email
    @log.type_ = @transaction.type_
    @log.item_name = @transaction.item_name
    @log.item_quantity = @transaction.item_quantity
    # @log.user_id = session[:user_id]

    if is_email_valid?(@transaction.requestor_email)
      if @transaction.save
        @log.save
        redirect_to(transactions_path)
      else
        render('new')
      end
    else
      flash[:notice] = 'Uh oh! The email that you entered is not a valid email address, try again!'
      render('new')
    end
  end

  # Update this to checkout items from database
  def checkout
    #emulate checkout/index
    @item = Item.find(params[:id])
  end

  def submit
    #emulate checkout/submit
    @item = Item.find(params[:id])
    @user = User.find(params[:uid])

    if (params[:checkout_amount].to_i > @item.avail_stock)
        flash[:notice] = "Sorry, there aren't enough items available to checkout"
        redirect_to({:controller => 'items', :action => 'index', :id => @item.id})
    else
      @item.avail_stock = @item.avail_stock-(params[:checkout_amount].to_i)
      if @item.merch == 'Yes'
          @item.total_stock = @item.total_stock - (params[:checkout_amount].to_i)
      end
      @item.save

      @user.item_ids.append(@item.id)
      @user.save

      @transaction = Transaction.new
      @transaction.user_id = @user.id
      @transaction.requestor_name = @user.first_name + " " + @user.last_name
      @transaction.requestor_email = @user.email
      @transaction.item_name = @item.name
      @transaction.item_quantity = params[:checkout_amount]
      @transaction.type_ = 'Checked Out'
      remind_date = Time.now + (2 * 7 * 24 * 60 * 60) # get the time current time and set it to two weeks later
      @transaction.remind_date = remind_date # might need to
      @transaction.event = params[:event]
      @transaction.save

      @log = Log.new
      @log.id = @transaction.id
      @log.requestor_name = @transaction.requestor_name
      @log.requestor_email = @transaction.requestor_email
      @log.type_ = @transaction.type_
      @log.item_name = @transaction.item_name
      @log.item_quantity = @transaction.item_quantity
      @log.event = @transaction.event

      @log.save

      redirect_to({:controller => 'items', :action => 'index'})
    end
  end

  # in this case, I am using edit/update as the "check in" form
  # Update this to re-enter Item into databse
  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    @log = Log.find(params[:id])
    @log.type_ = 'Checked In'
    time = Time.new
    @log.check_in = Date.new(time.year, time.month, time.day)
    @transaction.type_ = 'Checked In' # hopefully updates the 'type_' attribute in table

    # update to include items model

    @item = Item.find_by name: @transaction.item_name
    @item.avail_stock = @item.avail_stock+@transaction.item_quantity;
    if @item.merch == "Yes"
      @item.total_stock = @item.total_stock+@transaction.item_quantity;
      ## TODO: Create form to edit this value based on merch given away
    end
    @item.save;

    @user = User.find(@transaction.user_id)

    # TODO: Update to account for :return_amount in form
    @user.item_ids.delete(@item.id)
    @user.save

    if @transaction.save
      @log.save
      redirect_to(log_index_path)
    else
      render('edit')
    end
  end

  # these bottom two probably should never be used, but I included the definitions here just in case
  def delete; end

  def destroy; end

  # Create a function to view all items checked out by the user
  def showAllUserItems
      @transactions = Transaction.where(user_id: params[:id]).sorted
      @user = User.find(params[:id])
      if (params[:sort_type] != nil)
          @sort_type = params[:sort_type]
          @sort_dir = params[:sort_dir]
          if @sort_type == 'Item Name'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.item_name }
          elsif @sort_type == 'Person'
              @transactions_sorted = @transactions.sort_by { |transaction| [transaction.requestor_name] }
          elsif @sort_type == 'Checkout Date'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.updated_at.in_time_zone('America/Chicago').strftime('%I:%M:%S %p') }
          elsif @sort_type == 'Item Amount'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.item_quantity }
          elsif @sort_type == 'Event'
              @transactions_sorted = @transactions.sort_by { |transaction| transaction.event }
          end

          if @sort_dir == 'Z -> A'
              @transactions_sorted = @transactions_sorted.reverse
          end

      else
          @sort_type = 'Checkout Date'
          @sort_dir = 'A -> Z'
          @transactions_sorted = @transactions
      end
  end

  def transaction_params
    params.require(:transaction).permit(:requestor_name, :requestor_email, :type_, :item_name, :item_quantity, :remind_date, :event)
  end

#  def log_params
#    params.require(:log).permit(:requestor_name, :requestor_email, :type_, :item_name, :item_quantity, :check_in)
#  end

  # found article going over how to use regular expressions to validate email addresses entered into the form
  # link to article: https://blog.mailtrap.io/rails-email-validation/
  def is_email_valid?(email)
    email =~ REGEX_PATTERN
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
