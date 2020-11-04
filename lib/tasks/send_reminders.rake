desc "This task is called by the Heroku scheduler to send email reminders."

task :send_reminders => :environment do
    Transaction.all.each do |t|
        puts t.remind_date
        if Date.today < t.remind_date
            UserMailer.with(transaction: t).reminding_email.deliver
        end    
    end  
end 