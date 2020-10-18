require 'rails_helper'

RSpec.describe "Transactions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/transaction/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/transaction/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/transaction/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/transaction/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/transaction/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
