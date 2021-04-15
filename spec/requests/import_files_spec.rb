require 'rails_helper'

RSpec.describe "ImportFiles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/import_files/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/import_files/new"
      expect(response).to have_http_status(:success)
    end
  end

end
