# Add Devise helpers per https://github.com/plataformatec/devise/wiki/How-To%3a-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29

# The wiki suggested only including this in controller specs, but then
# any view that has condiional links complained it couldn't call
# authenticate on nil:NilClass 
# Trial and error suggests I need to have an include line for both controller and view 

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :view
end
