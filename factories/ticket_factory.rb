FactoryGirl.define do
  factory :ticket do
    title         "Ticket title"
    description   "Ticket description should be very descriptive."
    project
    user
  end
end
