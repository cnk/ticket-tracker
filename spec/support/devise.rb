# Add Devise helpers per https://github.com/plataformatec/devise/wiki/How-To%3a-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end
