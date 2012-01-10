FactoryGirl.define do
  factory :user do
    sequence(:email)        { |n| "user#{n}@ticketee.com" } 
    password                "password" 
    password_confirmation   "password" 
    confirmed_at            { Time.now() }
  end

  factory :admin, :class => User do
    sequence(:email)        { |n| "admin#{n}@ticketee.com" } 
    password                "password" 
    password_confirmation   "password" 
    confirmed_at            { Time.now() }
    admin                   true    
  end
end
