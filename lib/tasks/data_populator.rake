namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
      
      role = "admin"
      Role.create!(:name => role)
      role = "broker"
      Role.create!(:name => role)
      role = "user"
      Role.create!(:name => role)
      
      100.times do |n|
        first_name  = Faker::Name.first_name
        last_name = Faker::Name.last_name
        email = first_name + last_name + "@test.hu"
        password  = "password"
        role = "user"
        user = User.create!(:first_name => first_name,
                    :last_name => last_name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
         user.roles.create!(:name => role)
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
