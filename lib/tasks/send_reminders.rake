desc "This task is called by the Heroku scheduler to send email reminders."

task :send_reminders => :environment do
    
    # Transaction.find_each do |t|
    #     if Date.today  > t.created_at + 5.minutes
    #         UserMailer.with(transaction: t).reminding_email.deliver
    #     end    
    # end  
    UserMailer.with(transaction: Transaction).reminding_email.deliver
end 