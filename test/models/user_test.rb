require './spec/rails_helper'

#class UserTest < ActiveSupport::TestCase
RSpec.describe User, :type => :model do

  subject {
    described_class.new(first_name: "John",
                        last_name: "Doe",
                        email: "JohnDoe@email.com",
                        password: "supersecret")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with an improper email" do
    subject.email = "email";
    expect(subject).to_not be_valid
    subject.email = "email@email,com"
    expect(subject).to_not be_valid
    subject.email = "email@emailcom"
    expect(subject).to_not be_valid
  end
  
end
