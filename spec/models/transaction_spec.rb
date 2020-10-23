# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "is invalid with just a requestor_name"do
    transaction = Transaction.new(requestor_name: "testName")
    expect(transaction).to_not be_valid
  end

  it "is invalid with just a requestor_email"do
    transaction = Transaction.new(requestor_email: "testemail@swetamu.org")
    expect(transaction).to_not be_valid
  end

  it "is invalid with just a item_name"do
    transaction = Transaction.new(item_name: "pencil")
    expect(transaction).to_not be_valid
  end

  it "is invalid with just a item_quantity"do
    transaction = Transaction.new(item_quantity: 30)
    expect(transaction).to_not be_valid
  end

  it "is valid with requestor_name, requestor_email, item_name, and item_quantity" do
    transaction = Transaction.new(requestor_name: "testName", requestor_email: "testemail@swetamu.org", item_name: "pencil", item_quantity: 100)
    expect(transaction).to be_valid
  end
end
