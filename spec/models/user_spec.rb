# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do
  it { should have_many(:tickets).dependent(:nullify) }
  it { should have_many(:permissions).dependent(:destroy) }

  # email format - good
  %w(cnk@foo.com cnk@sub.foo.com first.last@example.org).each do |email|
    it { should allow_value(email).for(:email) }
  end
  # email format - bad
  %w(cnkfoo.com @twit fakefakefake).each do |email|
    it { should_not allow_value(email).for(:email) }
  end

  %w(admin encrypted_password sign_in_count password_salt confirmation_token confirmed_at).each do |column|
    it { should_not allow_mass_assignment_of(column) }
  end
end
