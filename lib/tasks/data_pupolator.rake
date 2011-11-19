namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
      100.times do |n|
        name  = "user#{n+1}"
        email = "user#{n+1}@test.hu"
        password  = "password"
        User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      end
      100.times do |n|
        name  = "Account#{n+1}"
        Account.create!(:name => name,
                        :balance => 100000,
                        :user_id => n+1
                   )
      end
      5.times do |n|
        name  = "Stock#{n+1}"
        Stock.create!(  :name => name )
      end
      100.times do |n|
        Order.create!(  :account_id => n+1,
                        :stock_id => 1,
                        :price => (n+2)/2*100,
                        :sell => n % 2,
                        :transaction_id => (n + 2)/2
                   )
      end
      50.times do |n|
        Transaction.create!( :created_at => (n / 5).days.ago )
      end
  end
end
