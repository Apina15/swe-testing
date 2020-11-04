desc "This task is called by the Heroku scheduler to send email reminders."

task :send_reminders => :environment do
    puts "first"
    Transaction.all.each do |t|
        puts "second"
        puts Date.today
        puts t.created_at + 14.days
        if Date.today < t.created_at + 14.days
            puts "third"
            UserMailer.with(transaction: t).reminding_email.deliver
        end    
    end  
end 