require 'rails_helper'

RSpec.describe User, type: :model do

  subject { described_class.new }

 it "is valid with valid attributes" do
 		  subject.username = "Sample Username"
 		  subject.email =  "jared@hot.com"
 		  subject.password = "password_digest"
 		  subject.first_name = "jared"
 		  subject.last_name = "hot"
 		  subject.gender = "male"
 		  subject.phone_num = 012222222
			subject.role ="user"
			
  expect(subject).to be_valid
    end

  it "is not valid without a username" do 
  expect(subject).to_not be_valid
end

  it "is not valid without a email" do
  expect(subject).to_not be_valid
end

  it "is not valid without a password" do
  expect(subject).to_not be_valid
end

  it "is not valid without a firstname" do
  expect(subject).to_not be_valid
end

it "email addresses should be saved as lower-case" do
	  subject.username = "Sample Username"
 		  subject.email =  "Jared@Hot.com"
 		  subject.password = "password_digest"
 		  subject.first_name = "jared"
 		  subject.last_name = "hot"
 		  subject.gender = "male"
 		  subject.phone_num = 012222222
			subject.role ="user"
	 subject.save!
	expect(subject.email).to eq("jared@hot.com")
end
end

