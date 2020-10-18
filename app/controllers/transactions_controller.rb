# frozen_string_literal: true

# found article going over how to use regular expressions to validate email addresses entered into the form
# link to article: https://blog.mailtrap.io/rails-email-validation/
# more work can be done to better validate email addresses
REGEX_PATTERN = /^(.+)@(.+)$/.freeze

class TransactionsController < ApplicationController
#  before_action :authorize, only: %i[create edit update delete destroy show new index]
  def index
    @transactions = Transaction.sorted
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new
    #@log = Log.new
  end

  def create
    @transaction = Transaction.new(transaction_params) # need to find out how to set the 2 week immediately
    @transaction.type_ = 'Checked Out'
    remind_date = Time.now + (2 * 7 * 24 * 60 * 60) # get the time current time and set it to two weeks later
    @transaction.remind_date = remind_date # might need to format this
    # @transaction.user_id = session[:user_id]

    #@log = Log.new
    #@log.id = @transaction.id
    #@log.requestor_name = @transaction.requestor_name
    #@log.requestor_email = @transaction.requestor_email
    #@log.type_ = @transaction.type_
    #@log.item_name = @transaction.item_name
    #@log.item_quantity = @transaction.item_quantity
    # @log.user_id = session[:user_id]

    if is_email_valid?(@transaction.requestor_email)
      if @transaction.save
        #@log.save
        flash[:notice] = 'Transaction Created Successfully!'
        redirect_to(transactions_path)
      else
        render('new')
      end
    else
      flash[:notice] = 'Uh oh! The email that you entered is not a valid email address, try again!'
      render('new')
    end
  end

  # in this case, I am using edit/update as the "check in" form
  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    #@log = Log.find(params[:id])
    #@log.type_ = 'Checked In'
    time = Time.new
    #@log.check_in = Date.new(time.year, time.month, time.day)
    @transaction.type_ = 'Checked In' # hopefully updates the 'type_' attribute in table

    if @transaction.save
    #  @log.save
      flash[:notice] = "Check Out ID #'#{@transaction.id}' Checked In Successfully!"
      redirect_to(transaction_path(@transaction))
    else
      render('edit')
    end
  end

  # these bottom two probably should never be used, but I included the definitions here just in case
  def delete; end

  def destroy; end

  def transaction_params
    params.require(:transaction).permit(:requestor_name, :requestor_email, :type_, :item_name, :item_quantity, :remind_date)
  end

#  def log_params
#    params.require(:log).permit(:requestor_name, :requestor_email, :type_, :item_name, :item_quantity, :check_in)
#  end

  # found article going over how to use regular expressions to validate email addresses entered into the form
  # link to article: https://blog.mailtrap.io/rails-email-validation/
  def is_email_valid?(email)
    email =~ REGEX_PATTERN
  end
end
