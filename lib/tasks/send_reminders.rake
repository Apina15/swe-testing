desc "This task is called by the Heroku scheduler to send email reminders."

task :send_reminders => :environment do
    Transaction.all.each do |transaction|
        if Date.today  > transaction.created_at + 5.minutes
            UserMailer.with(transaction: transaction).reminding_email.deliver
        end    
    end  
end 