require 'rails_helper'

RSpec.describe "FailedContacts", type: :request do
  describe "GET /inde" do
    it "returns http success" do
      get "/failed_contacts/inde"
      expect(response).to have_http_status(:success)
    end
  end

end
