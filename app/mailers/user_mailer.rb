class UserMailer < ApplicationMailer
    default from: 'SWE.InventoryTracker@gmail.com'
 
  def welcome_email
    @user = params[:user]
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to SWE Inventory Tracker')
  end
  
  def authorized_email
    @user = params[:user]
    #@url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You have been authorized to use SWE Inventory Tracker')
  end

  def admin_approval_email
    @user = params[:user]
    @admin = params[:admin]
    #@url  = 'http://example.com/login'
    mail(to: @admin.email, subject: 'New account registered on SWE Inventory Tracker')
  end

end
