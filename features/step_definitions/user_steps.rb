Given /^there are the following users:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |attributes|
    # default to false; the line below only returns true if unconfirmed is true
    unconfirmed = attributes.delete("unconfirmed") == "true"
    @user = User.create!(attributes)
    @user.confirm! unless unconfirmed
  end
end
