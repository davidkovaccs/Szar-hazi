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
        email = "user#{n+1}" + "@test.hu"
        password  = "password"
        role = "user"
        user = User.create!(:first_name => first_name,
                    :last_name => last_name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
         user.role_ids = [Role.find_by_name(role).id]
      end

      100.times do |n|
        name  = "Account#{n+1}"
        Account.create!(:name => name,
                        :balance => 100000,
                        :user_id => n+1
                   )
      end
      30.times do |n|
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
        Transaction.create!( :created_at => (9 - (n / 5)).days.ago,
                        :stock_id => 1,
                        :price => (n*2+2)/2*100
                  )
      end
      price = Array.new
      100.times do |n|
        if n % 2 == 0 then price[n/2] = rand(1000) end
        Order.create!(  :account_id => n+1,
                        :stock_id => 2,
                        :price => price[n/2],
                        :sell => n % 2,
                        :transaction_id => (n + 100 + 2)/2
                   )
      end
      50.times do |n|
        Transaction.create!(
                        :stock_id => 2,
                        :price => price[n],
                        :created_at => (9 - (n / 5)).days.ago)
      end
  end
end
